import 'package:dynamic_flutter/data/model/userinfo.dart';
import 'package:dynamic_flutter/services/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class UsersController extends GetxController with StateMixin<List<User>> {
  DBService db = Get.find();
  final isSearchClicked = false.obs;
  final currentquery = "".obs;
  @override
  void onInit() async {
    debounce(currentquery, (_) async {
      if (currentquery.value.trim() == "") {
        print("query changes");
        await getallUsers();
      } else {
        await getUsersByName(currentquery.value.trim());
      }
    }, time: const Duration(milliseconds: 200));
    await getallUsers();
    super.onInit();
  }

  Future<void> getallUsers() async {
    change(null, status: RxStatus.empty());
    change(null, status: RxStatus.loading());
    try {
      var users = await db.getAllUser();
      if (users.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getUsersByName(String name) async {
    change(null, status: RxStatus.empty());
    change(null, status: RxStatus.loading());
    var friends = await db.getSearchByName(name: name);
    if (friends.isEmpty) {
      change(null, status: RxStatus.error("No user found with query '$name'"));
    } else {
      change(friends, status: RxStatus.success());
    }
  }

  Future<void> deleteUser({required User user}) async {
    try {
      var isDeleted = await db.deleteUser(user: user);
      if (isDeleted) {
        var snackBar = const SnackBar(
          content: Text('Deleted successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        await getallUsers();
      } else {
        var snackBar = const SnackBar(
          content: Text('Deletion failed'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    } catch (e) {
      var snackBar = SnackBar(
        content: Text('Deletion failed due to ${e.toString()}'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      var isUpdated = await db.updateUser(user: user);
      if (isUpdated) {
        var snackBar = const SnackBar(
          content: Text('User Updated successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        await getallUsers();
        Get.back();
      } else {
        var snackBar = const SnackBar(
          content: Text('Error in updating friend'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    } catch (e) {
      if (e is DatabaseException) {
        var snackBar = SnackBar(
          content: Text('Error in updating user due to ${e.toString()}'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    }
  }
}
