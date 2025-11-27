import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowtap/glowtap/firebase/views/education_fb/eductiondatafirebasepage.dart';

class EducationSeeder {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Upload seluruh data Education & Tips ke Firestore
  static Future<void> uploadEducationItems() async {
    final items = AddEducationItems.educationList;

    for (var e in items) {
      // Auto-generate document ID
      final docRef = firestore.collection("education_items").doc();

      await docRef.set({
        "uid": docRef.id,
        "title": e.title,
        "category": e.category,
        "content": e.content,
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
      });
    }

    print("=== SELESAI UPLOAD DATA EDUCATION & TIPS ===");
  }
}
