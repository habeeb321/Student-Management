import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_5/model/model/data_model.dart';

class FunctionsDB with ChangeNotifier {
  static List<StudentModel> studentList = [];
  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(value.id, value);
    studentList.add(value);
    notifyListeners();
  }

  Future<List<StudentModel>> getAllStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDB.values);
    return studentList;
  }

  Future<void> deleteStudent(index) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(index);
    getAllStudent();
    notifyListeners();
  }

  Future<void> editList(int id, StudentModel value) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    studentDatabase.putAt(id, value);
    getAllStudent();
    notifyListeners();
  }
}
