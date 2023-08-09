




import 'package:get_storage/get_storage.dart';

import '../responses/userLoginResponse.dart';
import 'widgets/snackbars.dart';

class StorageCRUD{

  static GetStorage box=GetStorage();

  static Future write(String key, dynamic value)async{
    await box.write(key, value);
  }
  static Future read(String key)async{
    await box.read(key);
  }
  static Future remove(String key)async{
    await box.remove(key);
  }
  static Future erase()async{
    await box.erase();
  }

  static UserLoginResponse getUser() {
    UserLoginResponse userAuthModel = userLoginResponseFromJson(box.read(StorageKeys.userData));

    return userAuthModel;
  }

  static Future<void> saveUser(String data) async {
    await box.write(StorageKeys.userData, data);
    logger.i(box.read(StorageKeys.userData));
  }
}

class StorageKeys {
  static String userData = "userData";
}








