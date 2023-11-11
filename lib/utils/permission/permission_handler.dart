import 'package:permission_handler/permission_handler.dart' as permission_lib;

class PermissionHandler {
  static Future<bool> _requestPermission(
      permission_lib.Permission permission) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _permissionStatus = await permission.status;
    if (_permissionStatus.isGranted) {
      return true;
    } else if (!_permissionStatus.isPermanentlyDenied) {
      final newStatus = await permission.request();
      if (newStatus.isGranted) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> requestStoragePermission() async {
    return _requestPermission(permission_lib.Permission.storage);
  }

  static void openAppSettings() {
    permission_lib.openAppSettings();
  }
}
