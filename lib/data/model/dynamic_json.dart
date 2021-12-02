// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

class DynamicJson {
   Forme? form;
  DynamicJson({
      this.form,
  });

  DynamicJson copyWith({
    Forme? form,
  }) {
    return DynamicJson(
      form: form ?? this.form,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'form': form!.toMap(),
    };
  }

  factory DynamicJson.fromMap(Map<String, dynamic> map) {
    return DynamicJson(
      form: Forme.fromMap(map['form']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DynamicJson.fromJson(String source) => DynamicJson.fromMap(json.decode(source));

  @override
  String toString() => 'Dynamic_json(form: $form)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DynamicJson &&
      other.form == form;
  }

  @override
  int get hashCode => form.hashCode;
}

class Forme {
   String Button;
   List<Input> inputs;
  Forme({
    required this.Button,
    required this.inputs,
  });

  Forme copyWith({
    String? Button,
    List<Input>? inputs,
  }) {
    return Forme(
      Button: Button ?? this.Button,
      inputs: inputs ?? this.inputs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Button': Button,
      'inputs': inputs.map((x) => x.toMap()).toList(),
    };
  }

  factory Forme.fromMap(Map<String, dynamic> map) {
    return Forme(
      Button: map['Button'],
      inputs: List<Input>.from(map['inputs']?.map((x) => Input.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forme.fromJson(String source) => Forme.fromMap(json.decode(source));

  @override
  String toString() => 'Forme(Button: $Button, inputs: $inputs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Forme &&
      other.Button == Button &&
      listEquals(other.inputs, inputs);
  }

  @override
  int get hashCode => Button.hashCode ^ inputs.hashCode;
}

class Input {
  final String inputtype;
  final String label;
 String? Values;
  Input({
    required this.inputtype,
    required this.label,
    this.Values,
  });

  Input copyWith({
    String? inputtype,
    String? label,
    String? Values,
  }) {
    return Input(
      inputtype: inputtype ?? this.inputtype,
      label: label ?? this.label,
      Values: Values ?? this.Values,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inputtype': inputtype,
      'label': label,
      'Values': Values,
    };
  }

  factory Input.fromMap(Map<String, dynamic> map) {
    return Input(
      inputtype: map['inputtype'],
      label: map['label'],
      Values: map['Values'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Input.fromJson(String source) => Input.fromMap(json.decode(source));

  @override
  String toString() => 'Input(inputtype: $inputtype, label: $label, Values: $Values)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Input &&
      other.inputtype == inputtype &&
      other.label == label &&
      other.Values == Values;
  }

  @override
  int get hashCode => inputtype.hashCode ^ label.hashCode ^ Values.hashCode;
}