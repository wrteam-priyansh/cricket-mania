import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_mania/data/models/country.dart';
import 'package:cricket_mania/utils/constants.dart';

class CountryException implements Exception {
  String errorMessage;

  CountryException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class CountryRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Country>> fetchCountries() async {
    try {
      final querySnapshot =
          await _firebaseFirestore.collection(countriesCollection).get();

      return querySnapshot.docs
          .map((e) => Country.fromDocumentSnapshot(e))
          .toList();
    } on SocketException catch (_) {
      throw CountryException("No Internet");
    } catch (e) {
      print(e.toString());
      throw CountryException("Unable fetch country details ):");
    }
  }
}
