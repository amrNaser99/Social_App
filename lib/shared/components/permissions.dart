import 'package:permission_handler/permission_handler.dart';
import 'package:twasol/shared/network/local/cache_helper.dart';

import 'constants.dart';

class PermissionHandler {
  static Future<void> appPermission() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
      Permission.manageExternalStorage,
    ].request();

    permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted &&
        permissions[Permission.manageExternalStorage]!.isGranted;

    if (permissionsGranted == true) {
      CacheHelper.saveData(key: 'permissionsGranted', value: permissionsGranted)
          .then((value) {
        print('permissionsGranted Successfully');
      }).catchError((error) {});
    }
  }
}
