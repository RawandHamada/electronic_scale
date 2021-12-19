import 'package:electronic_scale/LaunchScreen.dart';
import 'package:electronic_scale/main_screen.dart';
import 'package:electronic_scale/hi_screen.dart';
import 'package:electronic_scale/preferences/app_preferences.dart';
import 'package:electronic_scale/profile_screen.dart';
import 'package:electronic_scale/screen_auth/create_account_screen.dart';
import 'package:electronic_scale/screen_auth/forget_password_screen.dart';
import 'package:electronic_scale/screen_auth/login_screen.dart';
import 'package:electronic_scale/today_scale_screen.dart';
import 'package:electronic_scale/view_branch_screen.dart';
import 'package:electronic_scale/view_category_screen.dart';
import 'package:electronic_scale/view_color_screen.dart';
import 'package:electronic_scale/view_scale_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPreferences().initPreferences();

  runApp( MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
  static changeLanguage(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) state.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(AppPreferences().language);


  void changeLocale(Locale locale) {
    AppPreferences().setLanguage(locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          //AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar')
          // Locale('en'),
        ],
        locale: _locale,
        initialRoute: '/launch_screen',
        routes:{
          '/launch_screen': (context) => LaunchScreen(),
          '/login_screen': (context) => LoginScreen(),
          '/hi_screen': (context) => HiScreen(),
          '/create_accont_screen': (context) => CreateAccountScreen(),
          '/forget_password_screen': (context) => ForgetPasswordScreen(),
          '/profile_screen': (context) => ProfileScreen(),
          '/view_scale_screen': (context) => ViewScaleScreen(),
          '/main_screen': (context) => MainScreen(),
          '/today_scale_screen': (context) => ToDayScaleScreen(),







        }


    );
  }
}



