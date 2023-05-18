import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  late final Stream<QuerySnapshot> streamPath;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getUid() {
    final User user = auth.currentUser!;
    final uid = user.uid.toString();
    return uid;
  }

  addTaskStream() {
    streamPath = _db
        .collection(getUid())
        .orderBy('createdAt', descending: true)
        .snapshots();
    return streamPath;
  }

  void addTask(String title, String description, String date) {
    _db.collection(getUid()).doc(title).set({
      "title": title,
      "description": description,
      "date": date == "Select the date" ? "" : date,
      "completed": false,
      "createdAt": FieldValue.serverTimestamp()
    });
  }

  void completeTask(String docName) {
    _db.collection(getUid()).doc(docName).update({"completed": true});
    _db
        .collection(getUid())
        .doc('completed')
        .update({"count": FieldValue.increment(1)});
  }

  void deleteTask(String docName) {
    _db.collection(getUid()).doc(docName).delete();
  }

  void updateTask(docName, String title, String description, String date) {
    deleteTask(docName);
    addTask(title, description, date);
  }
}
