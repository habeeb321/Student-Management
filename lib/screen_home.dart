import 'package:flutter/material.dart';
import 'package:week_5/model/functions/db_functions.dart';
import 'package:week_5/view/widgets/add_student_widget.dart';
import 'package:week_5/view/widgets/list_student_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showSearch(
        //         context: context,
        //         delegate: Search(),
        //       );
        //     },
        //     icon: const Icon(Icons.search),
        //   ),
        // ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListStudentWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudentWidget(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
