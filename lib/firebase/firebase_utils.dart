import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_scale/firebase/fb_auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FirebaseUtils {



  static updateFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    print("updateFirebaseToken $token");
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .update({'firebaseToken': token});
  }

  static removeFirebaseToken() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .update({'firebaseToken': ''});
  }


}
