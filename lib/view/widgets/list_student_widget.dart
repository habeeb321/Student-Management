import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_5/controller/provider/provider_student.dart';
import 'package:week_5/view/widgets/student_details.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderStudent>(
      builder: (BuildContext ctx, value, Widget? child) {
        if (value.foundUsers.isNotEmpty) {
          log(value.foundUsers.toString());
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final data = value.foundUsers[index];
              return ListTile(
                tileColor: Colors.blue[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
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
                    Text(data.mobile),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    ProviderStudent.deleteItem(
                      context,
                      data.id.toString(),
                    );
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
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: value.foundUsers.length,
          );
        } else {
          return const Center(
            child: Text(
              'Add some students',
              style: TextStyle(fontSize: 25),
            ),
          );
        }
      },
    );
  }
}
