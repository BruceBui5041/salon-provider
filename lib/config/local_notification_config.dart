// import 'package:timezone/timezone.dart';

// class LocalNotificationService {
//   // Singleton pattern (tùy chọn, đảm bảo có một instance duy nhất)
//   static final LocalNotificationService _instance =
//       LocalNotificationService._internal();
//   factory LocalNotificationService() => _instance;

//   LocalNotificationService._internal();

//   // Instance của plugin
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Hàm khởi tạo plugin, gọi trong hàm main() hoặc initState() của bạn
//   Future<void> init() async {
//     // Cấu hình cho Android
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     // Cấu hình cho iOS (nếu cần)
//     const DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       // onDidReceiveLocalNotification: ... // dùng cho iOS < 10.0
//     );

//     // Cấu hình tổng hợp
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Xử lý khi người dùng bấm vào notification
//         // Bạn có thể điều hướng hoặc thực hiện một logic nào đó ở đây
//       },
//     );
//   }

//   // Hàm hiển thị notification đơn giản
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id', // ID của kênh phải unique
//       'your_channel_name',
//       channelDescription: 'Mô tả kênh của bạn',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );

//     const DarwinNotificationDetails iosPlatformChannelSpecifics =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );

//     await _flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: payload,
//     );
//   }

//   // Hàm lên lịch notification
//   Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     // Cấu hình cho Android
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'scheduled_channel_id',
//       'Scheduled Notifications',
//       channelDescription: 'Notifications that appear at a scheduled time',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );

//     const DarwinNotificationDetails iosPlatformChannelSpecifics =
//         DarwinNotificationDetails();

//     final NotificationDetails notificationDetails = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       // Chuyển DateTime sang tzDateTime nếu cần quản lý timezone
//       // Giả sử đã cài đặt package timezone
//       // Mặc định có thể dùng như sau (không khuyến khích, nên cài timezone):
//       TZDateTime.from(scheduledTime, local),
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: null,
//     );
//   }

//   // Hàm hủy 1 notification
//   Future<void> cancelNotification(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }

//   // Hàm hủy tất cả notification
//   Future<void> cancelAllNotifications() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
