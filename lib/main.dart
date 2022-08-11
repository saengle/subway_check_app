import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_time_app/subway/subway_screen.dart';
import 'package:subway_time_app/subway/subway_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => SubwayViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SubwayScreen(),
    );
  }
}
