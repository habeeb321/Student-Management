import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_5/controller/core/constants.dart';
import 'package:week_5/controller/provider/provider_student.dart';
import 'package:week_5/model/functions/db_functions.dart';
import 'package:week_5/model/model/data_model.dart';

class EditStudent extends StatelessWidget {
  final String name;
  final String age;
  final String mobile;
  final String school;
  final String image;
  final int index;
  final String id;

  EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.mobile,
    required this.school,
    required this.index,
    required this.image,
    required this.id,
  });

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: name);
    _ageController = TextEditingController(text: age);
    _mobileController = TextEditingController(text: mobile);
    _schoolController = TextEditingController(text: school);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student Details'),
        centerTitle: true,
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
                  Consumer<ProviderStudent>(
                    builder: (context, value, Widget? child) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: value.uphoto == null
                              ? const CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                      AssetImage('assets/images/d3.png'),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(
                                      value.uphoto!.path,
                                    ),
                                  ),
                                  radius: 100,
                                ),
                        ),
                      );
                    },
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
                            elevation: 10),
                        onPressed: () {
                          Provider.of<ProviderStudent>(context, listen: false)
                              .getPhoto();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Update Image',
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
                  kHeight10,
                  TextFormField(
                    keyboardType: TextInputType.number,
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
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight10,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Mobile No',
                      labelText: 'Mobile No',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (value.length != 1) {
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
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            onEditSaveButton(context);
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Update'),
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

  Future<void> onEditSaveButton(ctx) async {
    final studentmodel = StudentModel(
      name: _nameController.text,
      age: _ageController.text,
      mobile: _mobileController.text,
      school: _schoolController.text,
      photo: image.toString(),
      id: id,
    );
    Provider.of<FunctionsDB>(ctx, listen: false).editList(index, studentmodel);
    Provider.of<FunctionsDB>(ctx, listen: false).getAllStudents();
    Navigator.of(ctx).pop();
    if (name.isEmpty ||
        age.isEmpty ||
        mobile.isEmpty ||
        school.isEmpty ||
        Provider.of<ProviderStudent>(ctx, listen: false).uphoto!.path.isEmpty) {
      return;
    } else {
      Provider.of<ProviderStudent>(ctx, listen: false).getAllStudents();
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Student Updated Sucessfully"),
        ),
      );
    }
  }
}
