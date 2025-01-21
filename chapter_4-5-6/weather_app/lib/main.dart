import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/models/src/app_settings.dart';
import 'package:weather_app/page/page_container.dart';
import 'package:weather_app/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppSettings settings = AppSettings();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp(settings: settings)));
}

class MyApp extends StatelessWidget {
  final AppSettings settings;

  const MyApp({super.key, required this.settings});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: false,
      fontFamily: "Cabin",
      primaryColor: AppColor.midnightSky,
      primaryTextTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColor.textColorDark,
            displayColor: AppColor.textColorDark,
          ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColor.textColorDark,
            displayColor: AppColor.textColorDark,
          ),
    );

    return MaterialApp(
      title: 'Wather App',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme:
            theme.colorScheme.copyWith(secondary: AppColor.midnightCloud),
      ),
      home: PageContainer(settings: settings),
    );
  }
}
