import 'dart:io';
import 'package:flutter/material.dart';
import 'package:week_5/controller/core/constants.dart';
import 'package:week_5/view/widgets/edit_student.dart';

class StudentDetails extends StatelessWidget {
  final String name;
  final String age;
  final String mobile;
  final String school;
  final String photo;
  final int index;
  final String? id;

  const StudentDetails({
    super.key,
    required this.name,
    required this.age,
    required this.mobile,
    required this.school,
    required this.photo,
    required this.index,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  kHeight20,
                  const Center(
                    child: Text(
                      'Student Full Details',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  kHeight20,
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(
                      File(photo),
                    ),
                  ),
                  kHeight20,
                  Text(
                    "Name: $name",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  kHeight20,
                  Text(
                    "Age: $age",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  kHeight20,
                  Text(
                    "Mobile: $mobile",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  kHeight20,
                  Text(
                    "School: $school",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  kHeight20,
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditStudent(
                name: name,
                age: age,
                mobile: mobile,
                school: school,
                index: index,
                image: photo,
                id: id.toString(),
              ),
            ),
          );
        },
        label: const Text('Edit'),
      ),
    );
  }
}
