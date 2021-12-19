import 'package:flutter/material.dart';
class HiScreen extends StatefulWidget {
  const HiScreen({Key? key}) : super(key: key);

  @override
  _HiScreenState createState() => _HiScreenState();
}

class _HiScreenState extends State<HiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 100),
          children: [
            SizedBox(height: 30,),
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
            SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Text(
                    'شركة مودال',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'مرحبا بك فى افضل واجود انواع البروفيلات ',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    ' الألمنيوم والأكسسورات ',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 70),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:Color(0XFF62BDF6),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: ()  => Navigator.pushNamed(context, '/login_screen'),
                    child: Text( 'تسجيل الدخول',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: ()   => Navigator.pushNamed(context, '/create_accont_screen'),
                    child: Text( 'انشاء حساب',style: TextStyle(color: Color(0XFF62BDF6),fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
