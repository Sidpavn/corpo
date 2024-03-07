
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:localstorage/localstorage.dart';

class UploadBackup {

  UploadBackup._privateConstructor();

  static final UploadBackup _instance = UploadBackup._privateConstructor();

  factory UploadBackup() {
    return _instance;
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference<Map<String, dynamic>> userRef = FirebaseFirestore.instance.collection("Users");

  LocalStorage storage = LocalStorage('corpo');

  Future uploadBackup() async {
    debugPrint('Uploading backup');
    await userRef.doc(uid).update(
      storage.getItem('player')
    );

    await userRef.doc(uid).collection('inventory').doc('storage').update(
        storage.getItem('storage')
    );
  }

}