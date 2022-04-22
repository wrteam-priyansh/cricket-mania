import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final String countryId;
  final String backgroundImageUrl;
  final String name;
  final String role;
  final int rank;

  Player(
      {required this.backgroundImageUrl,
      required this.countryId,
      required this.id,
      required this.name,
      required this.rank,
      required this.role});

  //It is similar to fromJson method
  static Player fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;
    return Player(
        backgroundImageUrl: json['backgroundImageUrl'],
        countryId: json['countryId'],
        id: documentSnapshot.id,
        name: json['name'],
        rank: json['rank'],
        role: json['role']);
  }
}
