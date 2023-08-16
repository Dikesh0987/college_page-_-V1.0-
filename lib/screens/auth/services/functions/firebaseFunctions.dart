import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  static saveUser(
      String name, email, password, verify, status, uid, collegId) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'userunique_id': uid,
      'collegeId': collegId,
      'email': email,
      'name': name,
      'password': password,
      'verify': verify,
      'status': status
    });
  }

  static saveuserIn(String userId, collegeId) {
    final CollectionReference collegesCollection =
        FirebaseFirestore.instance.collection('colleges');

    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    final collegeDocRef = collegesCollection.doc(collegeId);
    final connectionCollSubcollection = collegeDocRef.collection('collconn');

    connectionCollSubcollection.doc(userId).set({'status': 'pending'});

    final userDocRef = usersCollection.doc(userId);
    final connectionUserSubcollection = userDocRef.collection('collconn');

    connectionUserSubcollection.doc(collegeId).set({'status': 'pending'});
  }
}
