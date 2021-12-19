import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


typedef ImageEventHandler = void Function(
    bool status, String message, TaskState state,
    {Reference? reference});

class FbStorageController{
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // to get all images from the storage
  Future<List<Reference>> getImage() async {
    ListResult list = await _firebaseStorage.ref('images').listAll();
    if (list.items.isEmpty) {
      return list.items;
    }
    return [];
  }

  void upload({required File pickedFile, required ImageEventHandler eventsHandler}) {
    UploadTask uploadTask = _firebaseStorage
        .ref('images/${DateTime.now().millisecond}')
        .putFile(pickedFile);
    uploadTask.snapshotEvents.listen((event) {
      if (event.state == TaskState.running) {
        eventsHandler(false, 'its still running ', event.state);
      } else if (event.state == TaskState.success) {
        eventsHandler(true, 'Uploaded Successfully', event.state, reference: event.ref);
      } else if (event.state == TaskState.error) {
        eventsHandler(false, 'Upload Failed', event.state);
      }
    });
  }

  Future<bool> delete({required String path}) async {
    return await _firebaseStorage
        .ref(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}