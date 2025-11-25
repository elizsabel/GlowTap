import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowtap/glowtap/model/journalfirebasemodel.dart';

class JournalFirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collection = "journals";

  // CREATE
  static Future<void> addJournal(JournalFirebaseModel model) async {
    await _db.collection(collection).add(model.toMap());
  }

  // READ BY UID (real-time stream)
  static Stream<List<JournalFirebaseModel>> getJournals(String uid) {
    return _db
        .collection(collection)
        .where('uid', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) {
            return JournalFirebaseModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  // UPDATE
  static Future<void> updateJournal(JournalFirebaseModel model) async {
    if (model.id == null) return;
    // print(model.toJson());
    await _db.collection(collection).doc(model.id).update(model.toMap());
  }

  // DELETE
  static Future<void> deleteJournal(String id) async {
    await _db.collection(collection).doc(id).delete();
  }
}
