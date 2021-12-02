import 'package:dynamic_flutter/bindings/initialbindings.dart';
import 'package:dynamic_flutter/controllers/usercontrollers.dart';
import 'package:dynamic_flutter/pages/firstpage/firstpage.dart';
import 'package:dynamic_flutter/pages/userspage/userspage.dart';
import 'package:dynamic_flutter/services/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: "/first",
          page: () => FirstPage(),
        ),
        GetPage(
            name: "/users",
            page: () => const UsersPage(),
            binding: BindingsBuilder(() {
              Get.put(DBService());
              Get.put(UsersController());
            }))
      ],
      initialBinding: InitialBinding(),
      initialRoute: "/first",
    );
  }
}
