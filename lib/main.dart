import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_bloc/constans.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/repository/repository.dart';
import 'package:todo_task_bloc/data/source/hive_task_source.dart';
import 'package:todo_task_bloc/screen/home/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());
  await Hive.openBox<TaskEntity>(MyText.boxName);
  runApp(ChangeNotifierProvider<Repository<TaskEntity>>(
    create: (context) => Repository<TaskEntity>(
        HiveTaskDataSource(box: Hive.box(MyText.boxName))),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: GoogleFonts.urbanist().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: PersianFonts.vazirTextTheme,
      ),
      home: const MyHomePage(),
    );
  }
}
