import 'dart:developer';

import 'package:salon_provider/repositories/chat_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salon_provider/config/auth_config.dart';

import '../../config.dart';
import '../../model/response/booking_response.dart';
import '../../model/response/chatroom_response.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> chatList = [];
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();
  final ScrollController scrollController = ScrollController();

  String? bookingId;
  String? roomId;
  bool isLoading = false;
  bool isLoadingMore = false;
  String? currentUserId;
  String? customerId;
  String? earliestMessageId;

  // Add booking information
  Booking? booking;
  String userName = "";
  String serviceTitle = "";

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

    // Set up scroll controller for pagination
    scrollController.addListener(_onScroll);

    // Load chat room if we have a booking ID
    if (bookingId != null) {
      await loadBookingDetails();
      await loadChatRoom();
    } else {
      // Fallback to empty list for backward compatibility
      chatList = [];
    }

    notifyListeners();
  }

  void _onScroll() {
    if (scrollController.hasClients &&
        scrollController.position.pixels <=
            scrollController.position.maxScrollExtent *
                0.1 && // About 10% from the top
        !isLoadingMore &&
        roomId != null &&
        earliestMessageId != null) {
      loadMoreMessages();
    }
  }

  Future<void> loadBookingDetails() async {
    if (bookingId == null) return;

    try {
      booking = await _chatRepository.getBookingById(bookingId!);
      if (booking != null) {
        // Set user name from firstname and lastname
        userName =
            "${booking!.user?.firstname ?? ""} ${booking!.user?.lastname ?? ""}"
                .trim();
        if (userName.isEmpty) {
          userName = "User";
        }

        // Set service title if available
        if (booking!.serviceVersions != null &&
            booking!.serviceVersions!.isNotEmpty) {
          serviceTitle = booking!.serviceVersions!.first.title ?? "";
        }
      }
    } catch (e) {
      log('Error loading booking details: $e');
    }
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
        await loadMessages(rooms.first.lastMessageId);
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

      // Scroll to bottom after messages are loaded and UI is updated
      if (chatList.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    }
  }

  Future<void> loadMessages(String? lastMessageId) async {
    if (roomId == null) return;

    try {
      final messages = await _chatRepository.getMessagesByRoomWithLastMessage(
        roomId!,
        lastMessageId,
        isFirstLoad: true,
        limit: 20,
      );

      // Use the messages directly
      chatList = messages;

      // Store the earliest message ID for pagination
      if (chatList.isNotEmpty) {
        earliestMessageId = chatList.last.id;
      }

      // Reverse to show oldest first
      chatList = chatList.reversed.toList();
    } catch (e) {
      log('Error loading messages: $e');
    }
  }

  Future<void> loadMoreMessages() async {
    if (roomId == null || earliestMessageId == null || isLoadingMore) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      final messages = await _chatRepository.getMessagesByRoomWithLastMessage(
        roomId!,
        null,
        isFirstLoad: false,
        earliestMessageId: earliestMessageId,
        limit: 20,
      );

      if (messages.isNotEmpty) {
        // Store the new earliest message ID
        earliestMessageId = messages.last.id;

        // Save current scroll position and content height
        final double previousScrollOffset = scrollController.position.pixels;
        final double previousContentHeight =
            scrollController.position.maxScrollExtent;

        // Add the messages to the beginning of the list (they come in desc order)
        final oldMessages = messages.reversed.toList();
        chatList = [...oldMessages, ...chatList];

        // Notify listeners to rebuild the UI with new messages
        notifyListeners();

        // After UI is updated, restore scroll position accounting for new content
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            final double newContentHeight =
                scrollController.position.maxScrollExtent;
            final double contentHeightDifference =
                newContentHeight - previousContentHeight;
            scrollController.animateTo(
              previousScrollOffset + contentHeightDifference,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        // No more messages to load, set earliestMessageId to null to prevent further loading
        earliestMessageId = null;
      }
    } catch (e) {
      log('Error loading more messages: $e');
    } finally {
      isLoadingMore = false;
      notifyListeners();
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
    if (booking?.user?.phoneNumber != null) {
      makePhoneCall(Uri.parse('tel:${booking!.user!.phoneNumber}'));
    } else {
      makePhoneCall(Uri.parse('tel:+91 8200798552'));
    }
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

      // Scroll to bottom after UI is updated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });

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
    // Check both sender.id and senderId to handle both server messages and local temporary messages
    return message.sender?.id == currentUserId ||
        message.senderId == currentUserId;
  }

  // Add a reset method to clear all state
  void reset() {
    chatList = [];
    controller.clear();
    bookingId = null;
    roomId = null;
    isLoading = false;
    isLoadingMore = false;
    earliestMessageId = null;
    booking = null;
    userName = "";
    serviceTitle = "";
    notifyListeners();
  }

  // Dispose method to clean up resources
  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    controller.dispose();
    focus.dispose();
    super.dispose();
  }
}
