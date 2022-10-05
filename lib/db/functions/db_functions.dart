import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_5/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final ids = await studentDB.add(value);
  value.id = ids;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
  getAllStudent();
}

Future<void> getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  getAllStudent();
}

Future<void> editList(int id, StudentModel value) async {
  final studentDatabase = await Hive.openBox<StudentModel>('student_db');
  studentDatabase.putAt(id, value);
  getAllStudent();
}
