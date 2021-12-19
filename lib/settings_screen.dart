import 'package:electronic_scale/firebase/fb_auth_controller.dart';
import 'package:electronic_scale/firebase/firebase_utils.dart';
import 'package:electronic_scale/screen_auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut();
  }

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('الاعدادات'),
      ),
      body:   ListTile(
        onTap: () => signOut(),
        leading: Icon(Icons.logout,color:Color(0XFF62BDF6) ),
        title: Text('تسجيل الخروج '),
      ),

    );
  }
  Future<void> signOut() async {
    await _signOut();
    if (_firebaseAuth.currentUser == null) {
      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
     // Navigator.pushReplacement(context,'/login_screen');
   //   Navigator.push(LoginScreen());
      //await FirebaseUtils.removeFirebaseToken();

    }
    /*FirebaseAuth.instance.signOut().then((onValue) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => LoginScreen()));
    });*/
    //await FirebaseUtils.removeFirebaseToken();
  }

}
