import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:to_do_app_flutter/service/notification_manager.dart';
import 'package:to_do_app_flutter/service/shared_manager.dart';
import 'package:timezone/data/latest.dart' as tz;

final class Starter {
  Starter._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SharedManager.init();

    await NotificationHelper.initialize();

    MobileAds.instance.initialize();

    tz.initializeTimeZones();
  }
}
