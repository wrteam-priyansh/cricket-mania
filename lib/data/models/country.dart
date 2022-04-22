import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  final String id;
  final String name;
  final String imageUrl;
  final int rank;

  Country(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.rank});

  //It is similar to fromJson method
  static Country fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;
    return Country(
        id: documentSnapshot.id,
        imageUrl: json['imageUrl'],
        name: json['name'],
        rank: json['rank']);
  }
}
