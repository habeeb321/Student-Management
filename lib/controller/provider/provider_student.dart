import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week_5/model/functions/db_functions.dart';
import 'package:week_5/model/model/data_model.dart';

class ProviderStudent with ChangeNotifier {
  final List<StudentModel> studentList = FunctionsDB.studentList;
  File? uphoto;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      uphoto = photoTemp;
      notifyListeners();
    }
  }

  List<StudentModel> foundUsers = [];
  Future<void> getAllStudents() async {
    final students = await FunctionsDB().getAllStudent();
    foundUsers = students;

    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = studentList;
    } else {
      results = studentList
          .where((element) =>
              element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    foundUsers = results;
    notifyListeners();
  }
}
