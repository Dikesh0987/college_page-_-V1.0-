import 'package:college_page/model/college_model.dart';
import 'package:college_page/screens/auth/services/functions/collegeConn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/auth/services/functions/new_msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:college_page/core/theme/app_color.dart';

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
    final firestoreMsgService = FirestoreMsgService();

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
// for msg

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _msg = "";

    void _msgSend() {
      final collegeId =
          widget.collegeDoc.collegeUniqueId; // Initialize collegeId here
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        firestoreMsgService.newMsg(userId, collegeId, _msg);
      }
      _formKey.currentState!.reset();
    }

    // fow show or hide form
    bool _showForm = false;

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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('colleges')
                  .doc(widget.collegeDoc
                      .collegeUniqueId) // Replace with your specific doc ID
                  .collection('collconn')
                  .doc(userId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  // The document doesn't exist or the user ID doesn't match
                  // You can show a message or any other widget here
                  return Center(
                    child: Text('User ID not found in college collection.'),
                  );
                }

                // The document exists and user ID matches
                // Show the form
                _showForm = true;

                return _showForm
                    ? Expanded(
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('colleges')
                                  .doc(widget.collegeDoc.collegeUniqueId)
                                  .collection('msg')
                                  .orderBy('msgTime', descending: true)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> msgSnapshot) {
                                if (msgSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                if (msgSnapshot.hasError) {
                                  return Text('Error: ${msgSnapshot.error}');
                                }

                                if (!msgSnapshot.hasData ||
                                    msgSnapshot.data!.docs.isEmpty) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(
                                          'No messages available for this document.'),
                                    ),
                                  );
                                }

                                final messages = msgSnapshot.data!.docs;

                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: messages.length,
                                    reverse: true,
                                    padding: const EdgeInsets.all(24),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final messageData = messages[index].data()
                                          as Map<String, dynamic>;
                                      final msg = messageData['msg'];
                                      final senderId = messageData['userId'];

                                      // Check if senderId matches '83vd937gwisd8'
                                      if (senderId == userId) {
                                        return MyChat(
                                          chat: msg,
                                        );
                                      } else {
                                        return OthersChat(chat: msg);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      splashRadius: 20,
                                      icon: const Icon(
                                        Icons.emoji_emotions_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      onPressed: () {},
                                      splashRadius: 20,
                                      icon: const Icon(
                                        CupertinoIcons.photo,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextFormField(
                                        minLines: 1,
                                        maxLines: 5,
                                        key: ValueKey(_msg),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please mdg';
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          _msg = value!;
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Message....",
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      onPressed: () {
                                        _msgSend();
                                      },
                                      splashRadius: 20,
                                      icon: const Icon(
                                        CupertinoIcons.paperplane,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox.shrink(); // Hide the form if not needed
              },
            ),
          ],
        ),
      ),
    );
  }
}

// chats

class MyChat extends StatelessWidget {
  const MyChat({super.key, required this.chat});

  final String chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            color: AppColor.primaryColor,
          ),
          child: Text(
            chat,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColor.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.done_all,
                size: 18,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OthersChat extends StatelessWidget {
  const OthersChat({super.key, required this.chat});

  final String chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: AppColor.primaryColor.withOpacity(0.2),
          ),
          child: Text(
            chat,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
