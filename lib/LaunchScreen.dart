import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:electronic_scale/preferences/app_preferences.dart';
import 'package:flutter/material.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      String route = AppPreferences().loggedIn ? '/main_screen' : '/hi_screen';
      Navigator.pushReplacementNamed(context, route);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF62BDF6),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center  ,
          children: [
            Container(
              height: 120.0,
              width: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/logomodal.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 10),
            Text('أهلا بك ',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              fontSize: 24,),
            ),
            SizedBox(height: 5),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  ' شركة مودال للألمنيوم',
                  textStyle: const TextStyle(
                    fontSize: 30,
                    color: Color(0XFF015AAA),
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],

              totalRepeatCount: 4,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),

          ],
        ),
      )
    );
  }
}
