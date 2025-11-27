import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/educationmodel.dart';

class EducationService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = "education_items";

  /// ===============================
  /// GET SEMUA DATA
  /// ===============================
  static Future<List<EducationModel>> getAllEducation() async {
    final query = await _firestore
        .collection(_collection)
        .orderBy("createdAt", descending: true)
        .get();

    return query.docs
        .map((doc) => EducationModel.fromMap(doc.data()))
        .toList();
  }

  /// ===============================
  /// GET BERDASARKAN CATEGORY
  /// ===============================
  static Future<List<EducationModel>> getByCategory(String category) async {
    final query = await _firestore
        .collection(_collection)
        .where("category", isEqualTo: category)
        .get();

    return query.docs
        .map((doc) => EducationModel.fromMap(doc.data()))
        .toList();
  }

  /// ===============================
  /// GET DETAIL PER ITEM
  /// ===============================
  static Future<EducationModel?> getById(String uid) async {
    final doc = await _firestore.collection(_collection).doc(uid).get();

    if (!doc.exists) return null;

    return EducationModel.fromMap(doc.data()!);
  }

  /// ===============================
  /// TAMBAH DATA EDUCATION
  /// ===============================
  static Future<void> addEducation(EducationModel model) async {
    final docRef = _firestore.collection(_collection).doc();

    await docRef.set({
      "uid": docRef.id,
      "title": model.title,
      "category": model.category,
      "content": model.content,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  /// ===============================
  /// UPDATE EDUCATION
  /// ===============================
  static Future<void> updateEducation(EducationModel model) async {
    await _firestore.collection(_collection).doc(model.uid).update({
      "title": model.title,
      "category": model.category,
      "content": model.content,
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  /// ===============================
  /// DELETE EDUCATION
  /// ===============================
  static Future<void> deleteEducation(String uid) async {
    await _firestore.collection(_collection).doc(uid).delete();
  }

  /// ===============================
  /// SEEDER UPLOAD DUMMY DATA
  /// ===============================
  static Future<void> uploadDummy(List<EducationModel> items) async {
    for (var e in items) {
      final docRef = _firestore.collection(_collection).doc();

      await docRef.set({
        "uid": docRef.id,
        "title": e.title,
        "category": e.category,
        "content": e.content,
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
      });
    }

    print("=== DUMMY EDUCATION BERHASIL DIUPLOAD ===");
  }
}
