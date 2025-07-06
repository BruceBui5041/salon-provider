import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:salon_provider/config/constant_api_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// WebSocket API client for real-time communication
///
/// Example usage:
/// ```dart
/// // Initialize WebSocket connection
/// final wsApi = WebSocketApi();
/// await wsApi.connect(
///   endpoint: '/booking/notifications',
///   token: 'your_auth_token',
/// );
///
/// // Listen for messages
/// wsApi.messageStream.listen((message) {
///   if (message is Map && message['event'] == 'connected') {
///     print('Connected to WebSocket server');
///   } else if (message is Map && message['event'] == 'disconnected') {
///     print('Disconnected from WebSocket server');
///   } else if (message is Map && message['event'] == 'error') {
///     print('WebSocket error: ${message['data']}');
///   } else {
///     // Handle incoming messages
///     print('Received message: $message');
///   }
/// });
///
/// // Send a message
/// wsApi.send({
///   'type': 'subscribe',
///   'channel': 'booking_updates',
/// });
///
/// // Close the connection when done
/// wsApi.disconnect();
/// ```
class WebSocketApi {
  /// Singleton instance of WebSocketApi
  static WebSocketApi? _instance;

  /// Active WebSocket connection channel
  WebSocketChannel? _channel;

  /// Stream controller for broadcasting WebSocket messages to listeners
  final StreamController<dynamic> _messageController =
      StreamController<dynamic>.broadcast();

  /// Flag indicating if WebSocket is currently connected
  bool _isConnected = false;

  /// Timer for sending periodic ping messages to keep connection alive
  Timer? _pingTimer;

  /// Timer for handling reconnection attempts
  Timer? _reconnectTimer;

  /// Flag indicating if disconnect was manually triggered
  bool _manualDisconnect = false;

  /// Last connected endpoint for reconnection purposes
  String? _lastEndpoint;

  /// Last query parameters used for reconnection
  Map<String, dynamic>? _lastQueryParams;

  /// Last authentication token used for reconnection
  String? _lastToken;

  /// Counter for reconnection attempts
  int _reconnectAttempts = 0;

  /// Maximum number of reconnection attempts before giving up
  static const int _maxReconnectAttempts = 5;

  /// Stream of messages received from the WebSocket
  Stream<dynamic> get messageStream => _messageController.stream;

  /// Whether the WebSocket is currently connected
  bool get isConnected => _isConnected;

  factory WebSocketApi() {
    _instance ??= WebSocketApi._internal();
    return _instance!;
  }

  WebSocketApi._internal();

  Future<void> connect({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    String? token,
  }) async {
    if (_isConnected) return;

    // Store connection parameters for reconnection
    _lastEndpoint = endpoint;
    _lastQueryParams = queryParams;
    _lastToken = token;
    _manualDisconnect = false;

    await _connect(endpoint, queryParams, token);
  }

  Future<void> _connect(
    String endpoint,
    Map<String, dynamic>? queryParams,
    String? token,
  ) async {
    try {
      // Get base URL from config
      final baseUrl = ConstantApiConfig().getUrl;

      // Convert HTTP/HTTPS to WS/WSS
      String wsBaseUrl = baseUrl.replaceFirst(RegExp(r'^http'), 'ws');

      // Build the WebSocket URL with query parameters
      String url = '$wsBaseUrl$endpoint';
      if (queryParams != null && queryParams.isNotEmpty) {
        url += '?';
        queryParams.forEach((key, value) {
          url += '$key=$value&';
        });
        url = url.substring(0, url.length - 1); // Remove the trailing &
      }

      // Add authentication token as cookie if provided
      final headers = <String, dynamic>{
        if (token != null) 'Cookie': 'access_token=$token',
      };

      // Create WebSocket connection
      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: headers,
      );
      _isConnected = true;
      _reconnectAttempts = 0;

      // Start listening for messages
      _channel!.stream.listen(
        (data) {
          if (data != null) {
            try {
              final decodedData = jsonDecode(data);
              _messageController.add(decodedData);
            } catch (e) {
              _messageController.add(data);
            }
          }
        },
        onDone: () {
          _isConnected = false;
          _stopPingTimer();
          _messageController.add({'event': 'disconnected'});

          if (!_manualDisconnect) {
            _scheduleReconnect();
          }
        },
        onError: (error) {
          _isConnected = false;
          _stopPingTimer();
          _messageController.add({'event': 'error', 'data': error.toString()});

          if (!_manualDisconnect) {
            _scheduleReconnect();
          }
        },
      );

      // Start ping timer to keep connection alive
      _startPingTimer();

      _messageController.add({'event': 'connected'});
    } catch (e) {
      _isConnected = false;
      _messageController.add({'event': 'error', 'data': e.toString()});

      if (!_manualDisconnect) {
        _scheduleReconnect();
      }

      if (kDebugMode) {
        print('WebSocket connection error: $e');
      }
    }
  }

  void _scheduleReconnect() {
    _cancelReconnectTimer();

    if (_reconnectAttempts >= _maxReconnectAttempts ||
        _manualDisconnect ||
        _lastEndpoint == null) {
      return;
    }

    _reconnectAttempts++;
    _reconnectTimer = Timer(const Duration(seconds: 15), () {
      if (!_isConnected && !_manualDisconnect) {
        _messageController.add({
          'event': 'reconnecting',
          'attempt': _reconnectAttempts,
        });
        _connect(_lastEndpoint!, _lastQueryParams, _lastToken);
      }
    });
  }

  void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void send(dynamic data) {
    if (!_isConnected || _channel == null) {
      _messageController.add({'event': 'error', 'data': 'Not connected'});
      return;
    }

    try {
      String message;
      if (data is String) {
        message = data;
      } else {
        message = jsonEncode(data);
      }

      _channel!.sink.add(message);
    } catch (e) {
      _messageController.add({'event': 'error', 'data': e.toString()});
      if (kDebugMode) {
        print('WebSocket send error: $e');
      }
    }
  }

  void disconnect() {
    _manualDisconnect = true;
    _cancelReconnectTimer();

    if (_channel != null) {
      _stopPingTimer();
      _channel!.sink.close();
      _channel = null;
      _isConnected = false;
      _messageController.add({'event': 'disconnected'});
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      send({'event': 'ping'});
    });
  }

  void _stopPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _instance = null;
  }
}
