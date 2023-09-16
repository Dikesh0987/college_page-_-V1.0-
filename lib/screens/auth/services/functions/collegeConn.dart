import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService { 
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> joinCollege(String userId, String collegeId) async {
    try {
      final userDocRef = usersCollection.doc(userId);
      final connectionSubcollection = userDocRef.collection('collconn');

      await connectionSubcollection.doc(collegeId).set({'status': 'pending'});
      print('User $userId joined college $collegeId');
    } catch (e) {
      print('Error joining college: $e');
      rethrow; // Rethrow the exception for error handling
    }

    final CollectionReference collegesCollection =
        FirebaseFirestore.instance.collection('colleges');

    try {
      final collegeDocRef = collegesCollection.doc(collegeId);
      final connectionSubcollection = collegeDocRef.collection('collconn');

      await connectionSubcollection.doc(userId).set({'status': 'pending'});
      print('User $collegeId joined with college $userId');
    } catch (e) {
      print('Error joining college: $e');
      rethrow; // Rethrow the exception for error handling
    }
  }

  // for join like friends

  Future<void> friendsConn(String userId, String otherUserId) async {
    try {
      final userDocRef = usersCollection.doc(userId);
      final connectionSubcollection = userDocRef.collection('friendconn');

      await connectionSubcollection.doc(otherUserId).set({'status': 'pending'});
      print('User $userId joined friends $otherUserId');
    } catch (e) {
      print('Error joining college: $e');
      rethrow; // Rethrow the exception for error handling
    }

    try {
      final userDocRef = usersCollection.doc(otherUserId);
      final connectionSubcollection = userDocRef.collection('friendconn');

      await connectionSubcollection.doc(userId).set({'status': 'pending'});
      print('User $otherUserId joined friends $userId');
    } catch (e) {
      print('Error joining college: $e');
      rethrow; // Rethrow the exception for error handling
    }
  }
}
