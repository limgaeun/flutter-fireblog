import 'package:firebase_core/firebase_core.dart';
import 'package:fireblog_test/binding/app_binding.dart';
import 'package:fireblog_test/firebase_options.dart';
import 'package:fireblog_test/view/pages/user/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      home: LoginPage(),
    );
  }
}
