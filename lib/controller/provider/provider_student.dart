import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
    }
    notifyListeners();
  }

  List<StudentModel> foundUsers = [];
  Future<void> getAllStudents() async {
    final students = await FunctionsDB().getAllStudents();
    foundUsers = students;
    notifyListeners();
  }

  void addStudent(data) {
    foundUsers.clear();
    foundUsers.addAll(data);
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

  static deleteItem(BuildContext context, String id) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: const Text('Are you sure want to delete this ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Provider.of<FunctionsDB>(context, listen: false)
                      .deleteStudent(id);
                  Provider.of<ProviderStudent>(context, listen: false)
                      .getAllStudents();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Successfully deleted'),
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
          ],
        );
      },
    );
  }
}
