import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/service/notification_manager.dart';
import 'package:to_do_app_flutter/service/shared_manager.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/views/homepage.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedManager.init();
  await NotificationHelper.initialize();
  MobileAds.instance.initialize();
  tz.initializeTimeZones();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyService>(create: ((context) => MyService()))
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
      theme: ThemeData(
          textTheme: TextTheme(
        labelMedium: TextStyle(
          color: const Color(0xFF1B1A1C).withOpacity(0.6),
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          height: 0.09,
        ),
        titleMedium: const TextStyle(
          color: Color(0xFF1B1A1C),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 0.07,
        ),
        titleLarge: const TextStyle(
          color: Color(0xFF1B1A1C),
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 0.07,
        ),
        displaySmall: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0.03,
        ),
      )),
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}
