import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_page/model/chatuser_model.dart';
import 'package:college_page/model/message_model.dart';
import 'package:college_page/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserMsgService {
  // for authantication ..
  static FirebaseAuth auth = FirebaseAuth.instance;

  // cloudfirestore Accress ....
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  // for create a new connection id ..
  static String getConversationID(String id) {
    return user.uid.hashCode <= id.hashCode
        ? '${user.uid}_$id'
        : '${id}_${user.uid}';
  }

  static Future<void> sendMessage(
      UserModel OtherUser, String msg, Type type) async {
    //sent time
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // make msg
    final Message message = Message(
        toId: OtherUser.userunique_id,
        msg: msg,
        read: "",
        type: type,
        sent: time,
        fromId: user.uid);

    final ref = firestore.collection(
        'user_messages/${getConversationID(OtherUser.userunique_id)}/chats');
    await ref.doc(time).set(message.toJson());
    // await ref.doc(time).set(message.toJson()).then((value) =>
    //     sendPushNotifications(chatUser, type == Type.text ? msg : 'image'));
  }

  // get all msg form database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      String userId) {
    return FirestoreUserMsgService.firestore
        .collection('user_messages/${getConversationID(userId)}/chats')
        .orderBy('sent', descending: false)
        .snapshots();
  }
}
