import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/model/college_model.dart';
import 'package:college_page/model/user_model.dart';
import 'package:college_page/screens/auth/services/functions/collegeConn.dart';
import 'package:college_page/widget/home/chat_room_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/extension/date_time_extension.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class CollegeMembersWidget extends StatefulWidget {
  const CollegeMembersWidget({super.key, required this.collegeDoc});

  final CollegeModel collegeDoc;

  @override
  State<CollegeMembersWidget> createState() => _CollegeMembersWidgetState();
}

class _CollegeMembersWidgetState extends State<CollegeMembersWidget> {
  late List<UserModel> userList;
  bool isLoaded = false;

  // final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _displayData(); // Fetch data when the widget initializes
  }

  _displayData() async {
    try {
      var userDocRef = FirebaseFirestore.instance
          .collection("colleges")
          .doc(widget.collegeDoc.collegeUniqueId);
      var collconnSnapshot = await userDocRef.collection("collconn").get();

      List<String> usersIds = [];
      for (var collconnDoc in collconnSnapshot.docs) {
        usersIds.add(collconnDoc.id);
      }

      var collection = FirebaseFirestore.instance.collection("users");
      var data =
          await collection.where(FieldPath.documentId, whereIn: usersIds).get();

      List<UserModel> tempList = [];
      for (var element in data.docs) {
        tempList.add(UserModel.fromJson(element.data()));
      }

      setState(() {
        userList = tempList;
        isLoaded = true;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoaded = true;
      });
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
                "Members",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(CupertinoIcons.add_circled),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: isLoaded
                ? StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("colleges")
                        .doc(widget.collegeDoc.collegeUniqueId)
                        .collection("collconn")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text("No data available.");
                      }

                      List<String> collegeIds = [];
                      for (var doc in snapshot.data!.docs) {
                        collegeIds.add(doc.id);
                      }

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .where(FieldPath.documentId, whereIn: collegeIds)
                            .snapshots(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (userSnapshot.hasError) {
                            return Text("Error: ${userSnapshot.error}");
                          }

                          List<UserModel> userList = [];
                          for (var doc in userSnapshot.data!.docs) {
                            var userData = doc.data() as Map<String, dynamic>;
                            userList.add(UserModel.fromJson(userData));
                          }

                          return ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              return UserMembersCard(
                                user: userList[index],
                                isSelected: false,
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()))
      ],
    );
  }
}

class UserMembersCard extends StatelessWidget {
  const UserMembersCard({
    super.key,
    required this.isSelected,
    required this.user,
  });

  final UserModel user;
  final bool isSelected;

  // final firestoreService = FirestoreService();

  // final userId = FirebaseAuth.instance.currentUser!.uid;

  // void _join() async {
  //   final collegeId = college.collegeUniqueId; // Initialize collegeId here

  //   try {
  //     await firestoreService.joinCollege(userId, collegeId);
  //   } catch (e) {
  //     print('Failed to join college: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor.withOpacity(0.05) : null,
        ),
        foregroundDecoration: BoxDecoration(
          border: isSelected
              ? Border(
                  left: BorderSide(
                    color: AppColor.primaryColor,
                    width: 4,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Visibility(
              visible: true,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: Stack(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    '',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (true)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              user.email,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
