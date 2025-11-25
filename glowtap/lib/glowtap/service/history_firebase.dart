import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowtap/glowtap/model/historyfirebasemodel.dart';

class HistoryFirebaseService {
  static final _db = FirebaseFirestore.instance;
  static const String collection = "bookings";

  // CREATE
  static Future<void> addBooking(HistoryFirebaseModel model) async {
    await _db.collection(collection).add(model.toMap());
  }

  // READ by uid
  static Stream<List<HistoryFirebaseModel>> getBookingByUid(String uid) {
    return _db
        .collection(collection)
        .where("uid", isEqualTo: uid)
        .orderBy("date")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return HistoryFirebaseModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // UPDATE
  static Future<void> updateBooking(HistoryFirebaseModel model) async {
    await _db.collection(collection).doc(model.id).update(model.toMap());
  }

  // DELETE
  static Future<void> deleteBooking(String id) async {
    await _db.collection(collection).doc(id).delete();
  }
}
