import 'package:permission_handler/permission_handler.dart';

class HandlePermission {
  static Future<void> handleCamera() async {
    await Permission.camera.request();
  }

  static Future<void> handleMic() async {
    await Permission.microphone.request();
  }
}
