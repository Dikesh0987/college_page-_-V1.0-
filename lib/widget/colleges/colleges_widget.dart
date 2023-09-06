import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/model/college_model.dart';
import 'package:college_page/screens/auth/services/functions/collegeConn.dart';
import 'package:college_page/screens/college_profile/college_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/extension/date_time_extension.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class CollegesWidget extends StatefulWidget {
  const CollegesWidget({super.key});

  @override
  State<CollegesWidget> createState() => _CollegesWidgetState();
}

class _CollegesWidgetState extends State<CollegesWidget> {
  late List<CollegeModel> collegesList;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _displayData(); // Fetch data when the widget initializes
  }

  _displayData() async {
    try {
      var collection = FirebaseFirestore.instance.collection("colleges");
      var data = await collection.get();

      List<CollegeModel> tempList = [];
      data.docs.forEach((element) {
        tempList.add(CollegeModel.fromJson(element
            .data())); // Assuming CollegeModel has a constructor or factory method for JSON parsing
      });

      setState(() {
        collegesList = tempList;
        isLoaded = true;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoaded =
            true; // Even if an error occurs, set isLoaded to true to render the UI
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
                "Find Colleges",
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
                  child: const Icon(CupertinoIcons.search),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: isLoaded
                ? ListView.builder(
                    itemCount: collegesList.length,
                    itemBuilder: (context, index) {
                      return CollegesItem(
                        college: collegesList[
                            index], // Pass the individual CollegeModel object
                        isSelected: false,
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

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CollegeProfile(collegeModel: college)));
      },
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
              visible: isSelected,
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
                                  image: AssetImage("assets/mit.jpg"),
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
                              college.domain,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _join(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(CupertinoIcons.add),
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
