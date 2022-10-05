import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week_5/db/functions/db_functions.dart';
import 'package:week_5/db/model/data_model.dart';
import 'package:week_5/screens/home/screen_home.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  @override
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  bool imageAlert = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Add Student Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _photo?.path == null
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/d3.png'),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              _photo!.path,
                            ),
                          ),
                          radius: 60,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, elevation: 10),
                        onPressed: () {
                          getPhoto();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Add An Image',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your age',
                      labelText: 'Age',
                    ),
                    validator: (
                      value,
                    ) {
                      if (value == null || value.isEmpty) {
                        return 'Required Age ';
                      } else if (value.length > 100) {
                        return 'Enter Correct Age';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Mobile No',
                      labelText: 'Mobile No',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (value.length != 10) {
                        return 'Require valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _schoolController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter school name',
                      labelText: 'School',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required School Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _photo != null) {
                            onAddStudentButtonClicked();
                            Navigator.of(context).pop();
                          } else {
                            imageAlert = true;
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final mobile = _mobileController.text.trim();
    final school = _schoolController.text.trim();
    if (name.isEmpty ||
        age.isEmpty ||
        mobile.isEmpty ||
        school.isEmpty ||
        _photo!.path.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Student Added Successfully"),
        ),
      );
    }
    stdout.write('$name $age $mobile $school');
    final student = StudentModel(
      name: name,
      age: age,
      mobile: mobile,
      school: school,
      photo: _photo!.path,
    );
    addStudent(student);
  }

  Future<void> navigateToHome() async {
    getAllStudent();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScreenHome(),
      ),
    );
  }

  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      setState(
        () {
          _photo = photoTemp;
        },
      );
    }
  }
}
