import 'package:dynamic_flutter/controllers/jsoncontroller.dart';
import 'package:dynamic_flutter/data/model/dynamic_json.dart';
import 'package:dynamic_flutter/pages/registerpage/registerpage.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final JsonController jsonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Get.context!.height * 0.6,
                    child: TextFormField(
                        controller: jsonController.jsontextcontroller,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Enter your json here",
                          hintText: "Json",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: ValidationBuilder().required().build()),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      try {
                        var dynamicjson = DynamicJson.fromJson(
                            jsonController.jsontextcontroller.text);
                        jsonController.json = dynamicjson;
                        Get.to(() => const RegisterPage());
                      } catch (e) {
                        Get.defaultDialog(
                            title: 'Error',
                            content: const Text(
                                "Error parsing json.please check your json"));
                      }
                    }
                  },
                  child: const Text("Save"),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.to(() => const DatabaseList());
                //     },
                //     child: const Text('DB Viewer')),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.toNamed("/users");
                //     },
                //     child: const Text('Users Page'))
              ],
            )),
      ),
    );
  }
}
