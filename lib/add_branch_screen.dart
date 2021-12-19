import 'package:electronic_scale/firebase/fb_firestore_controller.dart';
import 'package:electronic_scale/models/branch.dart';
import 'package:electronic_scale/utils/helpers.dart';
import 'package:electronic_scale/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
class AddBranch extends StatefulWidget {
late Branch branch;

AddBranch(this.branch);

  @override
  _AddBranchState createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> with Helpers {
  late TextEditingController _branchTextController;
  var  branch;
  late List<dynamic> listBranch = [' '];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _branchTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _branchTextController.dispose();
    // _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xBF107AAA),
        elevation: 0,
        title: Text(
          'اضافه الافرع',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          AppTextField(
            hint: 'اسم الفرع',
            controller: _branchTextController,
          ),

          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performSave(),
            child: Text( 'اضافة الفرع'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xBF107AAA),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          Divider(
            height: 30,
            color: Colors.grey.shade500,
            thickness: 1,
          ),
          //streamItem(),
        ],
      ),
    );
  }

  Future<void> performSave() async {
    await addInArray();
  }


  Future<void> addInArray() async {
    List<dynamic> list = <dynamic>[_branchTextController.text];
    bool state = await FbFirestoreController().updateArray(
        nameDoc: 'branchs', nameArray: 'branchName', data: list);
    if (state) {
      showSnackBar(context: context, content: 'تم اضافة الفرع  بنجاح');
    }
  }


  void clear() {
    _branchTextController.text = '';
  }
}
