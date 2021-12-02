import 'package:dynamic_flutter/data/model/userinfo.dart';
import 'package:dynamic_flutter/services/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageController extends GetxController {
  DBService db = Get.find();

  Future<void> addAUser(User user) async {
    var count = 0;
    try {
      count = await db.insertUser(user: user);
      if (count != 0) {
        const snackBar = SnackBar(
          content: Text('User signedup successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        Get.toNamed("/users");
      }
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
        content: Text('Error in adding user'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }
}
