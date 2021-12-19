import 'package:electronic_scale/firebase/fb_auth_controller.dart';
import 'package:electronic_scale/models/user.dart';
import 'package:electronic_scale/utils/helpers.dart';
import 'package:electronic_scale/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late User _user;
  late TextEditingController _emailTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FbAuthController().user;
    _emailTextController = TextEditingController(text: _user.email ?? '');
    _nameTextController = TextEditingController(text: _user.displayName ?? '');
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _nameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        elevation: 1,
        backgroundColor: Color(0xBF107AAA),
        title: Text(
          'الملف الشخصي',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        children:[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [

              Container(
                height: 100,
                width: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),

                      Text(
                        _user.displayName ?? 'NO NAME',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        _user.email ?? 'NO EMAIL',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              Divider(
                height: 40,
                thickness: 1,
              ),
              AppTextField(
                hint: 'Email',
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                maxLength: 35,
              ),
              SizedBox(height: 10),
              AppTextField(
                hint: 'Name',
                controller: _nameTextController,
                maxLength: 30,
              ),
              SizedBox(height: 10),
              AppTextField(
                hint: 'Password',
                controller: _passwordTextController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await performUpdateProfile();
                },
                child: Text('SAVE'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
     ] ),
    );
  }

  Future<void> performUpdateProfile() async {
    if (checkData()) {
      updateProfile();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data');
    return false;
  }

  Future<void> updateProfile() async {
    bool updated = await FbAuthController().updateProfile(context,
        email: _emailTextController.text.trim(),
        name: _nameTextController.text.trimRight().trimLeft(),
        password: _passwordTextController.text);
    if (updated) {
      setState(() {
        _user = FbAuthController().user;
      });
      showSnackBar(context: context, content: 'Profile updated successfully');
    }
  }
}
