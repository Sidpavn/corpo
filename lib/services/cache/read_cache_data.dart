
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ReadCacheData {

  ReadCacheData._privateConstructor();

  static final ReadCacheData _instance = ReadCacheData._privateConstructor();

  factory ReadCacheData() {
    return _instance;
  }
  LocalStorage storage = LocalStorage('corpo');

  Future readCache() async {
    debugPrint('Reading data from the database for ' + FirebaseAuth.instance.currentUser!.uid.toString());

    /// Player details
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
      .get().then((ds){
        storage.setItem('player', ds.data());
      });

    /// Inventory
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory').doc('storage')
        .get().then((ds) {
          storage.setItem('storage', ds.data());
        });


    // template to add new fields after update
    // await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
    //   .collection('progression').doc('level')
    //   .get().then((ds) {
    //     if(ds.exists){
    //       storage.setItem('demo', ds.data());
    //     } else {
    //       storage.setItem('demo', {});
    //     }
    // });

  }
}
