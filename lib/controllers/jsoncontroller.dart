import 'package:dynamic_flutter/data/model/dynamic_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JsonController extends GetxController {
  DynamicJson? json = DynamicJson();
  final jsontextcontroller = TextEditingController(text: """{
   "form":{
      "Button":"Save",
      "inputs":[
         {
            "inputtype":"textbox",
            "label":"name",
            "Values":""
         },
         {
            "inputtype":"Date Picker",
            "label":"DOB",
            "Values":""
         },
         {
            "inputtype":"textbox",
            "label":"Mark",
            "Values":"50"
         },
         {
            "inputtype":"Combobox",
            "label":"Nationality",
            "Values":"India,UAE, USA etc"
         },
         {
            "inputtype":"RadioButton",
            "label":"Gender",
            "Values":"Male,Female"
         },
        
         {
            "inputtype":"CameraButton",
            "label":"Camera",
            "Values":""
         }
      ]
   }
}""");
}
