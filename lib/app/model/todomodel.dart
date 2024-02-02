import 'dart:io';

class TodoModel {
  int? id;
  late String name;
  File? image;
  late int age;
  late String course;
  late String address;
  late String  bloodgroup;
  late int phonenumber;

  TodoModel({
    this.id,
    required this.name,
    this.image,
    required this.age,
    required this.course,
    required this.address,
    required this.bloodgroup,
    required this.phonenumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age':age,
      'course': course,
      'address': address,
      'bloodgroup': bloodgroup,
       'phonenumber': phonenumber,
      'image': image == null ? '' : image!.path
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return  TodoModel(
        id: map['id'],
        name: map['name'],
        age: map['age'],
        course: map['course'],
        address: map['address'],
        bloodgroup: map['bloodgroup'],
        phonenumber: map['phonenumber'],
      
        image: map['image'] != null ? File(map['image']) : null);
  }
}