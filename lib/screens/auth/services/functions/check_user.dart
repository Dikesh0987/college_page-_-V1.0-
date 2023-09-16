import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkUser(String collegeId, String userId) async {
  try {
    final companyRef = FirebaseFirestore.instance.collection('colleges').doc(collegeId);
    final employeesQuery = companyRef.collection('collconn').doc(userId);

    final querySnapshot = await employeesQuery.get();

    if (querySnapshot.exists) {
      // User ID exists in the company's employees subcollection
      return true;
    } else {
      // User ID does not exist in the company's employees subcollection
      return false;
    }
  } catch (e) {
    print('Error checking user in company: $e');
    // Handle any errors here and return false in case of an error
    return false;
  }
}