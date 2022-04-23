import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_mania/data/models/player.dart';
import 'package:cricket_mania/utils/constants.dart';

class PlayerException implements Exception {
  String errorMessage;

  PlayerException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class PlayerRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Player>> fetchTopThreePlayers() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection(playersCollection)
          .orderBy("rank", descending: false)
          .limit(3)
          .get();

      return querySnapshot.docs
          .map((e) => Player.fromDocumentSnapshot(e))
          .toList();
    } on SocketException catch (_) {
      throw PlayerException("No Internet");
    } catch (e) {
      print(e.toString());
      throw PlayerException("Unable fetch players details ):");
    }
  }
}
