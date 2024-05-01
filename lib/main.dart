import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/starter.dart';
import 'package:to_do_app_flutter/theme.dart';
import 'package:to_do_app_flutter/views/homepage.dart';

Future<void> main() async {
  await Starter.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyService>(
        create: ((context) => MyService()),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MainThemeData().mainTheme,
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}
