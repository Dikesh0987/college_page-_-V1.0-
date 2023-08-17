import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/model/college_model.dart';
import 'package:college_page/screens/auth/services/functions/collegeConn.dart';
import 'package:college_page/widget/home/chat_room_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/extension/date_time_extension.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class ChatsWidget extends StatefulWidget {
  final Function(CollegeModel) onChatButtonClicked;

  ChatsWidget({required this.onChatButtonClicked});

  @override
  State<ChatsWidget> createState() => _ChatsWidgetState();
}

class _ChatsWidgetState extends State<ChatsWidget> {
  late List<CollegeModel> collegesList;
  bool isLoaded = false;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _displayData(); // Fetch data when the widget initializes
  }

  _displayData() async {
    try {
      var userDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);
      var collconnSnapshot = await userDocRef.collection("collconn").get();

      List<String> collegeIds = [];
      collconnSnapshot.docs.forEach((collconnDoc) {
        collegeIds.add(collconnDoc.id);
      });

      var collection = FirebaseFirestore.instance.collection("colleges");
      var data = await collection
          .where(FieldPath.documentId, whereIn: collegeIds)
          .get();

      List<CollegeModel> tempList = [];
      data.docs.forEach((element) {
        tempList.add(CollegeModel.fromJson(element.data()));
      });

      setState(() {
        collegesList = tempList;
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
                "Colleges",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/colleges');
                },
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
                        .collection("users")
                        .doc(userId)
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
                      snapshot.data!.docs.forEach((doc) {
                        collegeIds.add(doc.id);
                      });

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("colleges")
                            .where(FieldPath.documentId, whereIn: collegeIds)
                            .snapshots(),
                        builder: (context, collegeSnapshot) {
                          if (collegeSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (collegeSnapshot.hasError) {
                            return Text("Error: ${collegeSnapshot.error}");
                          }

                          List<CollegeModel> collegesList = [];
                          collegeSnapshot.data!.docs.forEach((doc) {
                            var collegeData =
                                doc.data() as Map<String, dynamic>;
                            collegesList
                                .add(CollegeModel.fromJson(collegeData));
                          });

                          return ListView.builder(
                            itemCount: collegesList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  CollegeModel college = collegesList[index];
                                  widget.onChatButtonClicked(college);
                                },
                                child: CollegesItem(
                                  college: collegesList[index],
                                  isSelected: false,
                                ),
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

class CollegesItem extends StatelessWidget {
  CollegesItem({
    super.key,
    required this.college,
    required this.isSelected,
  });

  final CollegeModel college;
  final bool isSelected;

  final firestoreService = FirestoreService();

  final userId = FirebaseAuth.instance.currentUser!.uid;

  void _join() async {
    final collegeId = college.collegeUniqueId; // Initialize collegeId here

    try {
      await firestoreService.joinCollege(userId, collegeId);
    } catch (e) {
      print('Failed to join college: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                              college.collegeName,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Time",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        college.websiteLink,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    college.district,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
