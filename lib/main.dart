import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:week_5/controller/provider/provider_student.dart';
import 'package:week_5/model/model/data_model.dart';
import 'package:week_5/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderStudent(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Page',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const ScreenHome(),
      ),
    );
  }
}
