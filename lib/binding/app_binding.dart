import 'package:fireblog_test/controller/user_controller.dart';
import 'package:fireblog_test/service/firebase_service.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {

  @override
  void dependencies() async {
    await Get.putAsync(() => FirebaseService().init());
    Get.put(() => UserController());
  }
}