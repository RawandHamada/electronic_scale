
import 'package:electronic_scale/firebase/fb_auth_controller.dart';
import 'package:electronic_scale/firebase/fb_firestore_controller.dart';
import 'package:electronic_scale/firebase/firebase_utils.dart';
import 'package:electronic_scale/models/user.dart';
import 'package:electronic_scale/utils/helpers.dart';
import 'package:electronic_scale/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late List<dynamic> listBranch = [];
  var branch;

  @override
  void initState() {
    // TODO: implement initState
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    getList(nameGetArray: 'branchName');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  //  SizeConfig().designWidth(3.72).designHeight(8.12).init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Color(0XFF62BDF6)
        ),
        elevation: 1,
        backgroundColor: Color(0XFF62BDF6),
        title: Text(
          'انشاء حساب جديد',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 100),
        children: [
          Text(
           "انشاء حساب",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "ادخل البريد الالكتروني و كلمة المرور",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          AppTextField(
            hint: "اسم الموظف",
            controller: _nameTextController,
            maxLength: 30,
          ),
          SizedBox(height: 10),
          AppTextField(
            hint: "البريد الالكتروني",
            controller: _emailTextController,
            maxLength: 30,
          ),
          SizedBox(height: 10),
          AppTextField(
            hint: "كلمة المرور",
            controller: _passwordTextController,
            obscureText: true,
          ),
          SizedBox(height: 20),
          Text(
            'الفرع',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),

          Card(
            elevation: 5,
            child: DropdownButton<dynamic>(
              underline: SizedBox(),
              autofocus: true,
              isDense: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              iconSize: 28,
              isExpanded: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              elevation: 3,
              dropdownColor: Colors.white,
              value: branch,
              onChanged: (newValue) {
                setState(() {
                  branch = newValue.toString();
                });
              },
              items: listBranch.map<DropdownMenuItem<dynamic>>((var value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 40,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary:Color(0XFF62BDF6),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await performCreateAccount();
            },
            child: Text("انشاء حساب"),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("هل لديك حساب",style: TextStyle(color: Color(0XFF62BDF6))),

                VerticalDivider(
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                  color: Colors.grey.shade500,
                  width: 1,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login_screen'),
                  child: Text("تسجيل الدخول",style: TextStyle(color: Color(0XFF62BDF6))),
                ),
              ],
            ),
          )
        ],
      ),

    );
  }

  Future<void> performCreateAccount() async {
    if (checkData()) {
      await createAccount();
    }
  }
  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

 Future<void> createAccount() async {
    bool status = await FbAuthController().createAccount(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status){
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailTextController.text, password: _passwordTextController.text);
   await  createAccountuser();
      await FirebaseUtils.updateFirebaseToken();

      Navigator.pushNamed(context, '/login_screen');

    }
  }
 Future<void> createAccountuser() async {
    bool status = await FbFirestoreController().CreateUserData(context, user: user);
    if (status) Navigator.pop(context);
  }
  Users get user{
    Users users =Users(
        name: _nameTextController.text,
        email: _emailTextController.text,
        uid: FbAuthController().getCurrentUserId(),
        password: _passwordTextController.text,
      //  isActive: '',
        nameBranch: branch.toString());
    return users;
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