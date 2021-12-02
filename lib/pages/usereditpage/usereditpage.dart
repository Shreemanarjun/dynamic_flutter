import 'dart:typed_data';

import 'package:dynamic_flutter/controllers/jsoncontroller.dart';
import 'package:dynamic_flutter/controllers/usercontrollers.dart';
import 'package:dynamic_flutter/data/model/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserEditPage extends StatefulWidget {
  final User user;

  const UserEditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final namecontroller = TextEditingController();

  final datecontroller = TextEditingController();

  final markcontroller = TextEditingController();

  final nationalities = <String>[].obs;

  final genders = <String>[].obs;

  final currentnationalityselected = "".obs;

  final currentgender = "".obs;

  final images = <Uint8List>[].obs;

  final _formkey = GlobalKey<FormState>();

  final UsersController usersController = Get.find();

  final JsonController jsonController = Get.find();

  initializeTextField() {
    namecontroller.text = widget.user.name;
    datecontroller.text = widget.user.dob;
    markcontroller.text = widget.user.mark;
    currentnationalityselected.value = widget.user.nationality;
    currentgender.value = widget.user.gender;
    nationalities
        .assignAll(jsonController.json!.form!.inputs[3].Values!.split(","));
    genders.assignAll(jsonController.json!.form!.inputs[4].Values!.split(","));
    images.assignAll([widget.user.image]);
  }

  @override
  void initState() {
    initializeTextField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(children: [
                    TextFormField(
                      controller: namecontroller,
                      validator: ValidationBuilder().required().build(),
                      decoration: const InputDecoration(labelText: 'name'),
                    ),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      controller: datecontroller,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2090),
                        );
                        if (date != null) {
                          datecontroller.text =
                              DateFormat('dd-MMM-yyyy').format(date);
                        }
                      },
                      validator: ValidationBuilder().required().build(),
                      decoration: const InputDecoration(
                        labelText: 'DOB',
                        //filled: true,
                        icon: Icon(Icons.calendar_today),
                        labelStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                    ),
                    TextFormField(
                      controller: markcontroller,
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder().required().build(),
                      decoration: const InputDecoration(labelText: 'marks'),
                    ),
                    if (nationalities.isNotEmpty)
                      Row(
                        children: [
                          const Text(
                            'nationality',
                          ),
                          Obx(() => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    value:
                                        currentnationalityselected.value == ""
                                            ? null
                                            : currentnationalityselected.value,
                                    isExpanded: true,
                                    hint: const Text("Select a nationality"),
                                    items: nationalities
                                        .map(
                                          (element) => DropdownMenuItem<String>(
                                            value: element,
                                            child: Text(element),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      currentnationalityselected.value =
                                          value ?? "";
                                    },
                                  ),
                                ),
                              )),
                        ],
                      )
                    else
                      const Text("No nationalities recieved"),
                    Row(
                      children: [
                        const Text(
                          'Gender',
                        ),
                        Expanded(
                          child: Obx(() => Wrap(
                                children: genders
                                    .map(
                                      (element) => RadioListTile<String>(
                                        value: element,
                                        groupValue: currentgender.value,
                                        activeColor: Colors.green,
                                        title: Text(element),
                                        onChanged: (val) {
                                          currentgender.value = val!;
                                        },
                                      ),
                                    )
                                    .toList(),
                              )),
                        ),
                      ],
                    ),
                    Obx(() => Wrap(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Image',
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            final ImagePicker _picker =
                                                ImagePicker();
                                            final XFile? photo =
                                                await _picker.pickImage(
                                                    source: ImageSource.camera);
                                            if (photo != null) {
                                              var image =
                                                  await photo.readAsBytes();
                                              images.assignAll([image]);
                                            }
                                          },
                                          child: const Text(
                                              "Get a picture from camera")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            final ImagePicker _picker =
                                                ImagePicker();
                                            final XFile? photo =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (photo != null) {
                                              var image =
                                                  await photo.readAsBytes();
                                              images.assignAll([image]);
                                            }
                                          },
                                          child: const Text(
                                              "Get a picture from gallery")),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (images.isNotEmpty)
                              Image.memory(
                                images.last,
                                height: 100,
                                width: 100,
                              )
                            else
                              const Text("No image selected")
                          ],
                        )),
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      if (currentnationalityselected.value.isNotEmpty &&
                          currentgender.value.isNotEmpty &&
                          images.isNotEmpty) {
                        await usersController.updateUser(User(
                            id: widget.user.id,
                            name: namecontroller.text,
                            dob: datecontroller.text,
                            mark: markcontroller.text,
                            nationality: currentnationalityselected.value,
                            gender: currentgender.value,
                            image: images.last));
                      } else if (currentnationalityselected.value.isEmpty) {
                        Get.snackbar("Nationality not selected",
                            "Please check nationality");
                      } else if (currentgender.value.isEmpty) {
                        Get.snackbar(
                            "Gender  not selected", "Please check nationality");
                      } else if (images.isEmpty) {
                        Get.snackbar(
                            "Images not selected", "Please check nationality");
                      }
                    }
                  },
                  child: const Text("Update")),
            )
          ],
        ),
      ),
    );
  }
}
