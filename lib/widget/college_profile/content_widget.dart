import 'package:college_page/model/college_model.dart';
import 'package:college_page/screens/auth/services/functions/collegeConn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
    this.showBackButton = false,
    required this.collegeDoc,
  });

  final CollegeModel collegeDoc;
  final bool showBackButton;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    final userId = FirebaseAuth.instance.currentUser!.uid;

    void _join() async {
      final collegeId =
          widget.collegeDoc.collegeUniqueId; // Initialize collegeId here

      try {
        await firestoreService.joinCollege(userId, collegeId);
      } catch (e) {
        print('Failed to join college: $e');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (widget.showBackButton) ...[
                    IconButton(
                      onPressed: () {
                        // Implement your back button logic
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                      ),
                      splashRadius: 20,
                    ),
                    const SizedBox(width: 16),
                  ],
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.collegeDoc.collegeName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.collegeDoc.domain,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 48,
                  //   child: TextButton.icon(
                  //     onPressed: () => _join(),
                  //     style: TextButton.styleFrom(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(16),
                  //       ),
                  //     ),
                  //     icon: Icon(
                  //       Icons.call_outlined,
                  //       color: Theme.of(context).textTheme.button?.color,
                  //     ),
                  //     label: Text(
                  //       "Join",
                  //       style: Theme.of(context).textTheme.button,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        _join();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text("Join"),
                    ),
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
