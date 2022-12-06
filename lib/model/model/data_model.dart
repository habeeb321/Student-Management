import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String mobile;

  @HiveField(4)
  final String school;

  @HiveField(5)
  final String photo;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.mobile,
    required this.school,
    required this.photo,
  });
}
