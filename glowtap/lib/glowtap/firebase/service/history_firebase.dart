import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/historyfirebasemodel.dart';

class HistoryFirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collection = "bookings";

  // CREATE
  static Future<void> addBooking(HistoryFirebaseModel model) async {
    await _db.collection(collection).add(model.toMap());
  }

  // READ (by UID)
  static Stream<List<HistoryFirebaseModel>> getHistory(String uid) {
    return _db
        .collection(collection)
        .where("uid", isEqualTo: uid)
        .orderBy("date", descending: true)
        .orderBy("__name__")
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => HistoryFirebaseModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  // UPDATE FULL
  static Future<void> updateBooking(HistoryFirebaseModel model) async {
    if (model.id == null) return;
    await _db.collection(collection).doc(model.id).update(model.toMap());
  }

  // UPDATE STATUS ONLY
  static Future<void> updateStatus(String id, String status) async {
    await _db.collection(collection).doc(id).update({"status": status});
  }

  // DELETE
  static Future<void> deleteHistory(String id) async {
    await _db.collection(collection).doc(id).delete();
  }
}
