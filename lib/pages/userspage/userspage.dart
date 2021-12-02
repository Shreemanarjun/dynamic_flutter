import 'package:dynamic_flutter/controllers/usercontrollers.dart';
import 'package:dynamic_flutter/data/model/userinfo.dart';
import 'package:dynamic_flutter/pages/usereditpage/usereditpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class UsersPage extends GetView<UsersController> {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: appbar(),
            preferredSize: Size(Get.context!.width, 60),
          ),
          body: controller.obx((users) {
            if (users != null) {
              final DataTableSource _data = Userdata(users, controller);
              return ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  PaginatedDataTable(
                    source: _data,
                    header: const Text('My Users'),
                    showFirstLastButtons: true,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'ID',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        'Name',
                        style: TextStyle(fontSize: 10),
                      )),
                      DataColumn(
                        label: Text(
                          'Mark',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        'Gender',
                        style: TextStyle(fontSize: 10),
                      )),
                      DataColumn(
                          label: Text(
                        'DOB',
                        style: TextStyle(fontSize: 10),
                      )),
                      DataColumn(
                          label: Text(
                        'Nationality',
                        style: TextStyle(fontSize: 10),
                      )),
                      DataColumn(
                          label: Text(
                        'Image',
                        style: TextStyle(fontSize: 10),
                      )),
                      DataColumn(
                          label: Text(
                        'Actions',
                        style: TextStyle(fontSize: 10),
                      ))
                    ],
                    columnSpacing: 4,
                    horizontalMargin: 4,
                    rowsPerPage: 5,
                    dataRowHeight: 100,
                    showCheckboxColumn: true,
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("No users added yet"),
              );
            }
          },
              onEmpty: const Center(
                child: Text("No users added yet"),
              ),
              onError: (e) => Center(
                    child: Text(e.toString()),
                  )),
        ),
      ),
    );
  }

  Widget appbar() {
    return Obx(
      () => !controller.isSearchClicked.value
          ? AppBar(
              title: const Text("Users"),
              actions: [
                IconButton(
                    onPressed: () {
                      controller.isSearchClicked.value = true;
                    },
                    icon: const Icon(Icons.search))
              ],
            )
          : SizedBox(
              height: 80,
              child: TextFormField(
                onChanged: (value) {
                  controller.currentquery.value = value;
                },
                autofocus: true,
                validator: ValidationBuilder().required().build(),
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: () {
                      controller.isSearchClicked.value = false;
                      controller.currentquery.value = "";
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
    );
  }
}

class Userdata extends DataTableSource {
  // Generate some made-up data
  final List<User> users;
  final UsersController usersController;
  Userdata(this.users, this.usersController);

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => users.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    var user = users[index];
    return DataRow(cells: [
      DataCell(Text(
        user.id.toString(),
        style: const TextStyle(fontSize: 10),
      )),
      DataCell(FittedBox(
        child: Text(
          user.name.toString(),
          style: const TextStyle(fontSize: 10),
        ),
      )),
      DataCell(Text(
        user.mark.toString(),
        style: const TextStyle(fontSize: 10),
      )),
      DataCell(
        Text(
          user.gender.toString(),
          style: const TextStyle(fontSize: 10),
        ),
      ),
      DataCell(FittedBox(
        child: Text(
          user.dob.toString(),
          style: const TextStyle(fontSize: 10),
        ),
      )),
      DataCell(Text(
        user.nationality.toString(),
        style: const TextStyle(fontSize: 10),
      )),
      DataCell(Image.memory(
        user.image,
        height: 40,
        width: 40,
      )),
      DataCell(Column(
        children: [
          IconButton(
              onPressed: () async {
                usersController.isSearchClicked.value = false;
                usersController.currentquery.value = "";

                Get.to(() => UserEditPage(
                      user: user,
                    ));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () async {
                usersController.isSearchClicked.value = false;
                usersController.currentquery.value = "";
                await usersController.deleteUser(user: user);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      )),
    ]);
  }
}
