import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/model/chatuser_model.dart';
import 'package:college_page/model/message_model.dart';
import 'package:college_page/model/user_model.dart';
import 'package:college_page/screens/auth/services/functions/collegeConn.dart';
import 'package:college_page/screens/auth/services/functions/user_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({
    super.key,
    this.showBackButton = false,
    required this.selectedUser,
  });
  final bool showBackButton;
  final UserModel selectedUser;

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final firestoreService = FirestoreService();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser;

  void _joinFriend() async {
    final otherUserId =
        widget.selectedUser.userunique_id; // Initialize collegeId here

    try {
      await firestoreService.friendsConn(userId, otherUserId);
    } catch (e) {
      print('Failed to join friend: $e');
    }
  }

// for chat

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _msg = "";

  final firestoreMsgService = FirestoreUserMsgService();

  void _msgSend() {
    // Initialize collegeId here
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      FirestoreUserMsgService.sendMessage(widget.selectedUser, _msg, Type.text);
    }
    _formKey.currentState!.reset();
  }

  // fow show or hide form
  bool _showForm = false;

  // for stogring all messages ..
  List<Message> _list = [];

  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                            widget.selectedUser.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "@college.ac.in",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: Icon(
                        Icons.call_outlined,
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                      label: Text(
                        "Friend Request",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _joinFriend,
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
                  .collection('users')
                  .doc(userId) // Replace with your specific doc ID
                  .collection('friendconn')
                  .doc(widget.selectedUser.userunique_id)
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
                            // StreamBuilder(
                            //   stream: FirestoreUserMsgService.getAllMessages(
                            //       widget.selectedUser.userunique_id),
                            //   builder: (context, snapshot) {
                            //     switch (snapshot.connectionState) {
                            //       // if data has been loading
                            //       case ConnectionState.waiting:
                            //       case ConnectionState.none:
                            //         return SizedBox();

                            //       // data lodede

                            //       case ConnectionState.active:
                            //       case ConnectionState.done:
                            //         final data = snapshot.data?.docs;

                            //         _list = data
                            //                 ?.map((e) =>
                            //                     Message.fromJson(e.data()))
                            //                 .toList() ??
                            //             [];

                            //         if (_list.isNotEmpty) {
                            //           return ListView.builder(
                            //               reverse: true,
                            //               itemCount: _list.length,

                            //               itemBuilder: (context, index) {
                            //                 print(_list[index].msg);
                            //                 return Text("data");

                            //               });
                            //         } else {
                            //           return Center(
                            //             child: Text(
                            //               "Say Hii ! 😊",
                            //               style: TextStyle(fontSize: 20),
                            //             ),
                            //           );
                            //         }
                            //     }
                            //   },
                            // ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('user_messages')
                                  .doc(
                                      FirestoreUserMsgService.getConversationID(
                                          widget.selectedUser.userunique_id))
                                  .collection('chats')
                                  .orderBy('sent', descending: true)
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
                                      final senderId = messageData['fromId'];

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
                                        controller: _textController,
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
