import 'dart:io';
import 'package:flutter/material.dart';
import 'package:week_5/screens/home/widgets/edit_student.dart';

class StudentDetails extends StatelessWidget {
  final String name;
  final String age;
  final String mobile;
  final String school;
  final String photo;
  final int index;

  StudentDetails({
    super.key,
    required this.name,
    required this.age,
    required this.mobile,
    required this.school,
    required this.photo,
    required this.index,
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
                  const Center(
                    child: Text(
                      'Student Full Details',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(
                      File(
                        photo,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Name: $name",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Age: $age",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mobile: $mobile",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "School: $school",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton.extended(
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
                            photo: '',
                          ),
                        ),
                      );
                    },
                    label: const Text('Edit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
