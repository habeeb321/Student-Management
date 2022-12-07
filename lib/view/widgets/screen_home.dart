import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_5/controller/core/constants.dart';
import 'package:week_5/controller/provider/provider_student.dart';
import 'package:week_5/view/widgets/add_student_widget.dart';
import 'package:week_5/view/widgets/list_student_widget.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<ProviderStudent>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.getAllStudents();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(
            builder: (context, ProviderStudent value, Widget? child) {
              return Column(
                children: [
                  CupertinoSearchTextField(
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(15),
                    prefixIcon:
                        const Icon(CupertinoIcons.search, color: Colors.black),
                    style: const TextStyle(color: Colors.black),
                    backgroundColor: Colors.grey.shade300,
                    controller: searchController,
                    onChanged: (value) {
                      Provider.of<ProviderStudent>(context, listen: false)
                          .runFilter(value);
                    },
                  ),
                  kHeight10,
                  Expanded(
                    child: ListStudentWidget(
                      controller: searchController,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProviderStudent>().uphoto = null;
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
