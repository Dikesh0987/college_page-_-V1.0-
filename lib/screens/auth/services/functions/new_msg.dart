import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreMsgService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('colleges');

  Future<void> newMsg(String userId, String collegeId, msg) async {
    DateTime now = DateTime.now();
    String formattedNow = formatDateTime(now);

    try {
      final userDocRef = usersCollection.doc(collegeId);

      final connectionSubcollection = userDocRef.collection('msg');

      await connectionSubcollection.doc().set({
        'status': 'pending',
        'msg': msg,
        'userId': userId,
        'msgTime': formattedNow
      });
    } catch (e) {
      print('not msg $e');
      rethrow; // Rethrow the exception for error handling
    }
  }

  String formatDateTime(DateTime dateTime) {
    // Define the desired date and time format
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    // Format the DateTime object as a string
    final String formattedDateTime = formatter.format(dateTime);

    return formattedDateTime;
  }
}
