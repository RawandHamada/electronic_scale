import 'package:electronic_scale/firebase/fb_auth_controller.dart';
import 'package:electronic_scale/firebase/fb_firestore_controller.dart';
import 'package:electronic_scale/firebase/firebase_utils.dart';
import 'package:electronic_scale/models/user.dart';
import 'package:electronic_scale/preferences/app_preferences.dart';
import 'package:electronic_scale/utils/helpers.dart';
import 'package:electronic_scale/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  var branch;
  late List<dynamic> listBranch = [];

  @override
  void initState() {
    // TODO: implement initState
    getList(nameGetArray: 'branchName');
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
    child: ListView(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
    children: [
    Container(
    height: 150.0,
    width: 120.0,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(
    'images/logomodal.jpg'),
    fit: BoxFit.scaleDown,
    ),
    shape: BoxShape.circle,
    ),
    ),
    SizedBox(height: 10),

    Center(
    child: Text(
    'شركة مودال',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    ),
    ),
    ),
    SizedBox(height: 10),
    Center(
    child: Text(
    'تسجيل الدخول ',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    ),
    ),
    ),
    SizedBox(height: 10),
    SizedBox(
    height: 40,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('انا لا املك حساب ؟',
    style: TextStyle(color: Colors.grey.shade500)),
    TextButton(
    onPressed: () =>
    Navigator.pushNamed(context, '/create_accont_screen'),
    child: Text("انشاء حساب",
    style: TextStyle(color: Color(0XFF62BDF6))),
    ),

    ],
    ),
    ),
    SizedBox(height: 10),
    AppTextField(
    hint: 'البريد الالكتروني',
    controller: _emailTextController,
    maxLength: 30,

    ),
    SizedBox(height: 10),
    AppTextField(
    hint: 'كلمة المرور',
    controller: _passwordTextController,
    obscureText: true,
    ),
    SizedBox(height: 10),
    ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: Color(0XFF62BDF6),
    minimumSize: Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    onPressed: () {
    performSignIn();
    },
    child: Text('تسجيل الدخول'),
    ),
    SizedBox(height: 10),
    SizedBox(
    height: 40,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [

    TextButton(
    onPressed: () =>
    Navigator.pushNamed(context, '/forget_password_screen'),
    child: Text("نسيت كلمة المرور",
    style: TextStyle(color: Color(0XFF62BDF6))),
    ),

    ],
    ),
    )
    ],
    ),
    ),
    );
  }

  Future<void> performSignIn() async {
    if (checkData()) {
      await signIn();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'الرجاء ادخال البيانات!');
    return false;
  }

  Future<void> signIn() async {
    await AppPreferences().save(user: user);
    bool status = await FbAuthController().signIn(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      showSnackBar(context: context, content: 'تم تسجيل الدخول');

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context,'/main_screen');

      });
      await FirebaseUtils.updateFirebaseToken();
    }
  }
  Future<void> createAccountuser() async {
    bool status = await FbFirestoreController().CreateUserData(context, user: user);
    if (status){
      Navigator.pop(context);
    }
  }

  Users get user {
    return Users(
        email: _emailTextController.text,
        uid: '', password: _passwordTextController.text, nameBranch:branch.toString(), name: ''
        //,isActive:''
    );

  }
  void getList({required String nameGetArray}) async {
    // جلب بيانات الليست
    List selectList = (await FbFirestoreController()
        .getArray(nameArray: nameGetArray)) as List;
    if (selectList.isNotEmpty) {
      listBranch = selectList;
      setState(() {});
    }
  }
}
