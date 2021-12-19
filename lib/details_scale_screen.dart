import 'package:electronic_scale/models/scale.dart';
import 'package:flutter/material.dart';
class DetailScaleScreen extends StatefulWidget {
 Scale scale;
DetailScaleScreen(this.scale);

  @override
  _DetailScaleScreenState createState() => _DetailScaleScreenState(scale);
}

class _DetailScaleScreenState extends State<DetailScaleScreen> {
   Scale scale;
  _DetailScaleScreenState(this.scale);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title:  Text( "تفاصيل الوزن"
          , style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children:[
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
              children: [
                Container(
                  height: 350,
                  width: 400,
                  child: Image.network(
                    scale.pathImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 350,
                  width: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text( "اسم الزبون",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Cairo'),),
                          Text( scale.nameCustomer,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo'),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text( "الوزن",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                          Text( scale.weight,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text( "الصنف",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                          Text( scale.nameCategory,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text( "اللون",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                          Text( scale.nameColor,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                        ],
                      ),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text( "الفرع",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                          Text( scale.nameBranch,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                        ],
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text( "التاريخ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                          Text( scale.date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,fontFamily: 'Cairo',color: Colors.blueGrey),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text( scale.title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,fontFamily: 'Cairo'),),
                      ),
                    ],
                  ),
                )
              ]
          ),


        ),
    ]
      ),
    );
  }
}
