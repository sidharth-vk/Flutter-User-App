import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAllUserDetails() async {
    return await FirebaseFirestore.instance.collection("User").snapshots();
  }

  Future updateUser(String id, Map<String, dynamic> updateDetails) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .update(updateDetails);
  }

  Future deleteUser(String id) async {
    return await FirebaseFirestore.instance.collection("User").doc(id).delete();
  }
}
