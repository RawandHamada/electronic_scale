import 'dart:async';
import 'dart:io';

import 'package:electronic_scale/firebase/fb_auth_controller.dart';
import 'package:electronic_scale/firebase/fb_firestore_controller.dart';
import 'package:electronic_scale/firebase/fb_notifications.dart';
import 'package:electronic_scale/firebase/fb_storage_controller.dart';
import 'package:electronic_scale/models/scale.dart';
import 'package:electronic_scale/models/user.dart';
import 'package:electronic_scale/utils/helpers.dart';
import 'package:electronic_scale/widgets/app_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddScaleScreen extends StatefulWidget {
  Scale _scale;
  AddScaleScreen(this._scale);




  @override
  _AddScaleScreenState createState() => _AddScaleScreenState(_scale);
}

class _AddScaleScreenState extends State<AddScaleScreen> with Helpers , FbNotifications {

  Scale _scale;
  _AddScaleScreenState(this._scale);
  late List<dynamic> listBranch = [];
  late List<dynamic> listColor = [];
  late List<dynamic> listCategory = [];
  var branch;
  var color;
  var category;
  var uid;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String url;
  late TextEditingController _nameCustomer;
  late TextEditingController _weight;
  late TextEditingController _title;
  DateTime dateTime = DateTime.now();
  String date= '';
  String time='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameCustomer = TextEditingController();
    _title = TextEditingController();
    _weight = TextEditingController();
    getListcolor(nameGetArray: 'ColorName');
    getListcategory(nameGetArray: 'categoryName');
    date=convertDateTimeDisplay(dateTime.toString());
    time=convertTimeDisplay(dateTime.toString());
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameCustomer.dispose();
    _title.dispose();
    _weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),

        elevation: 1,
        backgroundColor: Color(0xBF107AAA),

        title: Text( 'الميزان الالكتروني',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        children:[
          Column(
            children: [
             Text('اسم الزبون',style: TextStyle(
                fontSize: 20,
              ),),
              SizedBox(
                height: 20,
              ),
              AppTextField(hint: 'اسم الزبون', controller: _nameCustomer,),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 157,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.9)),
                            ),
                            IconButton(
                              onPressed: () {
                               // _pickDate(context);
                              },
                              icon: Icon(
                                Icons.date_range,
                                color: Color(0xFF4B53F5),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 157,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             time,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.9)),
                            ),
                            IconButton(
                              onPressed: () {
                              //  _pickTime(context);
                              },
                              icon: Icon(
                                Icons.access_time_outlined,
                                color: Color(0xFF4B53F5),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'اللون',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 50,
                child: Card(
                  elevation: 1,
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
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    elevation: 3,

                    dropdownColor: Colors.white,
                    value: color,
                    onChanged: (newValue) {
                      setState(() {
                        color = newValue.toString();
                      });
                    },
                      items: listColor.map<DropdownMenuItem<dynamic>>((var value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(
                height:15,
              ),
              Text(
                'الصنف',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 50,
                child: Card(
                  elevation: 1,
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
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    elevation: 3,

                    dropdownColor: Colors.white,
                    value: category,
                    onChanged: (newValue) {
                      setState(() {
                        category = newValue.toString();
                      });
                    },
                      items: listCategory.map<DropdownMenuItem<dynamic>>((var value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AppTextField(hint: 'الوزن', controller: _weight,keyboardType: TextInputType.number,),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(fontSize: 16),
                maxLength: 200,
                minLines: 2,
                maxLines: 5,
                controller: _title,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF62BDF6))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF62BDF6))),
                  counterText: '',
                  labelText: 'البيان',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.white70.withOpacity(0.61),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    showPicker(context);
                  },
                  child: Container(
                    width: 500,
                    height: 250,
                    child: pickedImage != null
                        ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(pickedImage!.path),
                          ),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.cloud_upload,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              LinearProgressIndicator(
                value: _currentValue,
              ),
              SizedBox(height: 10),
              Text(
                "اضافه الصور",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {performAddScale();},
                child: Text(
                  'حفظ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0XFF62BDF6),
                    minimumSize: Size(double.infinity, 50)),
              )
            ],
          ),
    ]
      ),
    );
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('صور من الاستديو'),
                    onTap: () {
                      pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('كاميرا'),
                  onTap: () {
                    pickImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
  Future<void> pickImageCamera() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  void uploadImage() {
    _currentValue = null;
    if (pickedImage != null) {
      FbStorageController().upload(
        pickedFile: File(pickedImage!.path),
        eventsHandler: (bool status, String message, TaskState state,
            {Reference? reference}) async {
          if (status) {
            showSnackBar(context: context, content: message);
            changeCurrentIndicator(1);
            downloadURLExample(reference: reference);
          } else {
            if (status == TaskState.running) {
              changeCurrentIndicator(0);
            } else {
              // showSnackBar(context: context, content: message, error: true);
              changeCurrentIndicator(null);
            }
          }
        },
      );
    } else {
      showSnackBar(
          context: context, content: 'تم رفع الصورة', error: true);
    }
  }

  void changeCurrentIndicator(double? currentIndicator) {
    setState(() {
      _currentValue = currentIndicator;
    });
  }

  Future<void> downloadURLExample({Reference? reference}) async {
    url = await reference!.getDownloadURL();
  }


  void getListcolor({required String nameGetArray}) async {
    // جلب بيانات الليست
    List selectListColor = (await FbFirestoreController()
        .getArrayColor(nameArray: nameGetArray));
    if (selectListColor.isNotEmpty) {
      listColor = selectListColor;
      setState(() {});
    }
  }
  void getListcategory({required String nameGetArray}) async {
    // جلب بيانات الليست
    List selectListCategory = (await FbFirestoreController()
        .getArrayCategory(nameArray: nameGetArray));
    if (selectListCategory.isNotEmpty) {
      listCategory = selectListCategory;
      setState(() {});
    }
  }

  Future<bool> performAddScale() async {
    if (checkData()) {
    user.uid = FbAuthController().getCurrentUserId();
      await FbFirestoreController().CreateScale(
          collectionName: 'Scale', scale: scales);
      print('user uid${user.uid}');
      showSnackBar(
          context: context, content: 'تمت اضافة الوزنة', error: false);
      Navigator.of(context).pop();
      return true;
    }return false;
  }
  Users get user{
    Users users =Users(
        uid: '',
        nameBranch: branch.toString(), name: '', password: '', email: '');
    return users;
  }
Scale get scales{
  Scale scales=Scale();
  scales.title=_title.text;
  scales.pathImage=url;
  scales.nameCustomer=_nameCustomer.text;
  scales.nameColor=color.toString();
  scales.nameCategory=category.toString();
  DateTime dateTime = DateTime.now();
  scales.date= convertDateTimeDisplay(dateTime.toString());
  scales.time=convertTimeDisplay(dateTime.toString());
  scales.weight=_weight.text;
  scales.uid=FbAuthController().user.uid;
  return scales;

}

  String convertDateTimeDisplay(String date) {
     final displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final serverFormater = DateFormat('dd-MM-yyyy');
     final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  String convertTimeDisplay(String date) {
    final displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final serverFormater = DateFormat('HH:mm:ss');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }


  bool checkData() {
    if (_nameCustomer.text.isNotEmpty &&
        _title.text.isNotEmpty  ) {
      if (pickedImage != null) {
        return true;
      }
      return false;
    }
    showSnackBar(
        context: context, content: 'الرجاء ادخال البيانات المطلوبة', error: true);
    return false;
  }


}

