import 'dart:io';

import 'package:cricket_mania/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class AuthException implements Exception {
  String errorMessage;

  AuthException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class AuthRepository {
  bool getIsLogIn() {
    return Hive.box(authBoxKey).get("isLogIn") ?? false;
  }

  Future<void> setIsLogIn(bool value) async {
    return Hive.box(authBoxKey).put("isLogIn", value);
  }

  String getFirebaseUId() {
    return Hive.box(authBoxKey).get("firebaseUId") ?? "";
  }

  Future<void> setFirebaseUId(String value) async {
    return Hive.box(authBoxKey).put("firebaseUId", value);
  }

  Future<void> signOutUser() async {
    FirebaseAuth.instance.signOut();
    setIsLogIn(false);
    setFirebaseUId("");
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid ?? "";
    } on SocketException catch (_) {
      throw AuthException("No Internet");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw AuthException(e.message ?? "Unable to auth ):");
    } catch (e) {
      print(e.toString());
      throw AuthException("Unable to auth ):");
    }
  }
}
