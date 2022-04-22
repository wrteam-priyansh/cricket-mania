import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_mania/data/models/userDetails.dart';
import 'package:cricket_mania/utils/constants.dart';

class UserException implements Exception {
  String errorMessage;

  UserException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<UserDetails> fetchUserDetails({required String userId}) async {
    try {
      final documentSnapshot = await _firebaseFirestore
          .collection(usersCollection)
          .doc(userId)
          .get();

      return UserDetails.fromDocumentSnapshot(documentSnapshot);
    } on SocketException catch (_) {
      throw UserException("No Internet");
    } catch (e) {
      print(e.toString());
      throw UserException("Unable fetch user details ):");
    }
  }
}
