import 'dart:io';
import 'package:flutter/material.dart';
import 'package:week_5/db/functions/db_functions.dart';
import 'package:week_5/db/model/data_model.dart';
import 'package:week_5/screens/home/widgets/student_details.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return Card(
              color: Colors.blue[100],
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(
                    File(data.photo),
                  ),
                ),
                title: Text(data.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.age),
                    Text(data.mobile),
                    Text(data.school),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    deleteStudent(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentDetails(
                        name: data.name,
                        age: data.age,
                        mobile: data.mobile,
                        school: data.school,
                        index: index,
                        photo: data.photo,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
