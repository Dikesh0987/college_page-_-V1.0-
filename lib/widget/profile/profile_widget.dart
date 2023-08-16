import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/widget/home/chat_room_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  // for getting user data
  Map<String, dynamic> userData = {};

  @override 
  void initState() {
    super.initState();
    fetchAndSetUserData();
  }

  Future<void> fetchAndSetUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) 
            .get();
        if (documentSnapshot.exists) {
          setState(() {
            userData = documentSnapshot.data() as Map<String, dynamic>;
          });
        }
      }
    } catch (e) {
      print('Error fetching and setting user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        Text('${userData['name'] ?? 'N/A'}')
      ],
    );
  }
}
