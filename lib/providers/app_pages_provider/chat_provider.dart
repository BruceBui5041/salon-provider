import 'dart:developer';

import 'package:salon_provider/repositories/chat_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salon_provider/config/auth_config.dart';

import '../../config.dart';
import '../../model/response/chatroom_response.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> chatList = [];
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();
  final ScrollController scrollController = ScrollController();

  String? bookingId;
  String? roomId;
  bool isLoading = false;
  String? currentUserId;
  String? customerId;

  final ChatRepository _chatRepository;
  ChatProvider(this._chatRepository);

  Future<void> onReady(BuildContext context) async {
    // Store the booking ID from arguments if available
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      bookingId = args;
    }

    // Get current user ID
    currentUserId = await AuthConfig.getUserId();

    // Load chat room if we have a booking ID
    if (bookingId != null) {
      await loadChatRoom();
    } else {
      // Fallback to empty list for backward compatibility
      chatList = [];
    }

    notifyListeners();
  }

  Future<void> loadChatRoom() async {
    if (bookingId == null) return;

    isLoading = true;
    notifyListeners();

    try {
      // Try to find existing chat room for this booking
      final rooms = await _chatRepository.getChatRoomsByBooking(bookingId!);

      if (rooms.isNotEmpty) {
        // Chat room exists, load messages
        roomId = rooms.first.id;
        await loadMessages();
      } else {
        // No chat room exists yet, we'll create one when sending first message
        // Get customer ID from booking for later use
        customerId = await _chatRepository.getCustomerIdFromBooking(bookingId!);
        chatList = [];
      }
    } catch (e) {
      log('Error loading chat room: $e');
      chatList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMessages() async {
    if (roomId == null) return;

    try {
      final messages =
          await _chatRepository.getMessagesByRoom(roomId!, limit: 20);

      // Use the messages directly
      chatList = messages;

      // Reverse to show oldest first
      chatList = chatList.reversed.toList();
    } catch (e) {
      log('Error loading messages: $e');
    }
  }

  Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onTapPhone() {
    makePhoneCall(Uri.parse('tel:+91 8200798552'));
    notifyListeners();
  }

  //send message
  Future<void> setMessage() async {
    if (controller.text.isEmpty) return;

    try {
      final messageContent = controller.text;

      // Create a temporary message to show immediately
      ChatMessage messageModel = ChatMessage(
        content: messageContent,
        senderId: currentUserId,
        messageType: MessageType.text,
      );

      chatList.add(messageModel);
      controller.text = "";
      notifyListeners();

      // Scroll to bottom only if controller is attached
      _scrollToBottom();

      // If we don't have a room ID yet but have booking ID, create a room
      if (roomId == null && bookingId != null) {
        try {
          if (currentUserId != null && bookingId != null) {
            // If we don't have customerId yet, get it from booking
            customerId ??=
                await _chatRepository.getCustomerIdFromBooking(bookingId!);

            if (customerId != null) {
              // Create chat room with booking ID
              final response = await _chatRepository.createChatRoomWithBooking(
                currentUserId!,
                customerId!,
                bookingId!,
              );

              if (response.data != null) {
                roomId = response.data!.id;
              }
            } else {
              log('Error: Could not get customer ID from booking');
            }
          }
        } catch (e) {
          log('Error creating chat room: $e');
        }
      }

      // Send message if we have a room ID
      if (roomId != null) {
        await _chatRepository.sendMessage(
          roomId!,
          messageContent,
        );
      }
    } catch (e) {
      log('Error sending message: $e');
    }
  }

  void _scrollToBottom() {
    // Only scroll if positions is not empty (controller is attached)
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void onClearChat(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.clearChat,
        appFonts.clearChat, appFonts.areYouClearChat, () {
      route.pop(context);
      value.onResetPass(context, language(context, appFonts.hurrayChatDelete),
          language(context, appFonts.okay), () => Navigator.pop(context));
    });
    value.notifyListeners();
  }

  bool isSentByMe(ChatMessage message) {
    return message.sender?.id == currentUserId;
  }
}
