import 'dart:convert';

class User {
    int? id;
  String name;
  String dob;
  String mark;
  String nationality;
  String gender;
  dynamic image;
  User({
    this.id,
    required this.name,
    required this.dob,
    required this.mark,
    required this.nationality,
    required this.gender,
    required this.image,
  });
 

  User copyWith({
    int? id,
    String? name,
    String? dob,
    String? mark,
    String? nationality,
    String? gender,
    dynamic image,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      mark: mark ?? this.mark,
      nationality: nationality ?? this.nationality,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'mark': mark,
      'nationality': nationality,
      'gender': gender,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      dob: map['dob'],
      mark: map['mark'],
      nationality: map['nationality'],
      gender: map['gender'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, dob: $dob, mark: $mark, nationality: $nationality, gender: $gender, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.name == name &&
      other.dob == dob &&
      other.mark == mark &&
      other.nationality == nationality &&
      other.gender == gender &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      dob.hashCode ^
      mark.hashCode ^
      nationality.hashCode ^
      gender.hashCode ^
      image.hashCode;
  }
}
