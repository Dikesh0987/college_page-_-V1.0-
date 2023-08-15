import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddData {
  static Future<void> addCollege(
    String campusTour,
    String collegeName,
    String district,
    String domain,
    String logo,
    String state,
    String websiteLink,
    String uniqueId,
    BuildContext context,
  ) async {
    try {
      Uuid uuid = Uuid();
      String documentId = uuid.v4();
      // Save college data to Firestore using 'Firestoredata.saveCollege' (you need to implement this)
      await Firestoredata.saveCollege(campusTour, collegeName, district, domain,
          logo, state, websiteLink, documentId);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific authentication exceptions
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Provided is too weak')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email Provided already Exists')),
        );
      }
    } catch (e) {
      // Handle other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}

class Firestoredata {
  static saveCollege(String campustour, name, district, domain, logo, state,
      websitelink, unique) async {
    await FirebaseFirestore.instance.collection('colleges').doc(unique).set({
      'campus_tour': campustour,
      'college_name': name,
      'district': district,
      'domain': domain,
      'logo': logo,
      'state': state,
      'website_link': websitelink,
      'collegeunique_id': unique
    });
  }
}

