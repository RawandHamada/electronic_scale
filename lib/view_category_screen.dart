import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_scale/add_branch_screen.dart';
import 'package:electronic_scale/firebase/fb_firestore_controller.dart';
import 'package:electronic_scale/models/branch.dart';
import 'package:flutter/material.dart';
class ViewCategoryScreen extends StatefulWidget {

  @override
  _ViewCategoryScreenState createState() => _ViewCategoryScreenState();
}

class _ViewCategoryScreenState extends State<ViewCategoryScreen> {
 // late String url;
  late List<dynamic> listCategory = [];
  @override
  void initState() {
    // TODO: implement initState
    getList(nameGetArray: 'categoryName');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xBF107AAA),
        title: Text( "الاصناف",style: TextStyle(color: Colors.white),),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FbFirestoreController().readArrayCategory(nameCollection:'Category'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data1 = snapshot.data!.docs;
            return ListView.separated(
              itemCount: listCategory.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30,
                        child: Icon(Icons.workspaces_filled, color: Color(0xBF107AAA))),
                    title: Text(listCategory[index]),
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryScreen(listCategory[index])));
                    },


                  ),
                );

              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );

          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                  Text(
                    "لايوجد اصناف",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ) ,
     /* floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xBF107AAA),
        onPressed: () {
          Branch branch = Branch();
          branch.address = '';
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBranch(branch )));
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
  void getList({required String nameGetArray}) async {
    // جلب بيانات الليست
    List selectListCategory = (await FbFirestoreController()
        .getArrayCategory(nameArray: nameGetArray));
    if (selectListCategory.isNotEmpty) {
      listCategory = selectListCategory;
      setState(() {});
    }
  }

}
