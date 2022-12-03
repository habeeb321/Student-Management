import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_5/controller/core/constants.dart';
import 'package:week_5/controller/provider/provider_student.dart';
import 'package:week_5/model/functions/db_functions.dart';
import 'package:week_5/model/model/data_model.dart';

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key});

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
                  kHeight10,
                  Provider.of<ProviderStudent>(context).uphoto?.path == null
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/d3.png'),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              Provider.of<ProviderStudent>(context).uphoto!.path,
                            ),
                          ),
                          radius: 60,
                        ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, elevation: 10),
                        onPressed: () {
                          Provider.of<ProviderStudent>(context).getPhoto();
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
                  kHeight10,
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Your Name is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight10,
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your age',
                    ),
                    validator: (
                      value,
                    ) {
                      if (value == null || value.isEmpty) {
                        return 'Your Age is required';
                      } else if (value.length > 100) {
                        return 'Enter Correct Age';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight10,
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Mobile No',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Your Phone Number is required';
                      } else if (value.length != 10) {
                        return 'Require valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight10,
                  TextFormField(
                    controller: _schoolController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter school name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Your School Name is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              Provider.of<ProviderStudent>(context).uphoto !=
                                  null) {
                            onAddStudentButtonClicked(context);
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

  Future<void> onAddStudentButtonClicked(context) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final mobile = _mobileController.text.trim();
    final school = _schoolController.text.trim();
    if (name.isEmpty ||
        age.isEmpty ||
        mobile.isEmpty ||
        school.isEmpty ||
        Provider.of<ProviderStudent>(context).uphoto!.path.isEmpty) {
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
      photo: Provider.of<ProviderStudent>(context).uphoto!.path,
    );
    addStudent(student);
  }

  // Future<void> navigateToHome(context) async {
  //   getAllStudent();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const ScreenHome(),
  //     ),
  //   );
  // }

}
