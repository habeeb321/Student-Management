import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_5/controller/provider/provider_student.dart';
import 'package:week_5/model/functions/db_functions.dart';
import 'package:week_5/view/widgets/student_details.dart';

class ListStudentWidget extends StatelessWidget {
  ListStudentWidget({super.key, required this.controller});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProviderStudent>(
        builder: (BuildContext ctx, studentList, Widget? child) {
          return studentList.foundUsers.isEmpty
              ? const Center(
                  child: Text(
                    'Add some students',
                    style: TextStyle(fontSize: 25),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final data = studentList.foundUsers[index];
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
                          Provider.of<FunctionsDB>(context, listen: false)
                              .deleteStudent(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20),
                              content: Text("Student Deleted Successfully"),
                            ),
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
                  itemCount: studentList.foundUsers.length,
                );
        },
      ),
    );
  }
}
