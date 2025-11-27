import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/userfirebasemodelpage.dart';
import 'package:glowtap/glowtap/firebase/preference_firebase/preference_handler_firebase.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ======================================================
  // REGISTER USER
  // ======================================================
  static Future<UserFirebaseModel> registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user!;
      final model = UserFirebaseModel(
        uid: user.uid,
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      await firestore.collection('users').doc(user.uid).set(model.toMap());

      return model;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw "Email sudah terdaftar";
      } else if (e.code == "weak-password") {
        throw "Password terlalu lemah";
      } else if (e.code == "invalid-email") {
        throw "Email tidak valid";
      } else {
        throw e.message ?? "Register gagal";
      }
    } catch (e) {
      throw "Terjadi kesalahan: $e";
    }
  }

  // ======================================================
  // LOGIN USER
  // ======================================================
  static Future<UserFirebaseModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) return null;

      final snap = await firestore.collection('users').doc(user.uid).get();
      if (!snap.exists) return null;

      // Buat model lengkap dari Firestore
      final model = UserFirebaseModel.fromMap({
        'uid': user.uid,
        ...snap.data()!,
      });

      // =============================================
      // SIMPAN SESSION LOGIN
      // =============================================
      await PreferenceHandlerFirebase.saveToken(user.uid);
      await PreferenceHandlerFirebase.saveUserFirebase(model);
      await PreferenceHandlerFirebase.saveLogin(true);

      return model;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") throw "Akun tidak ditemukan";
      if (e.code == "wrong-password") throw "Password salah";
      throw e.message ?? "Login gagal";
    } catch (e) {
      throw "Terjadi kesalahan: $e";
    }
  }
}
