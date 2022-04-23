import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String id; //firebaseUId
  final String name;

  UserDetails({required this.id, required this.name});

  static UserDetails fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;
    return UserDetails(id: documentSnapshot.id, name: json['name']);
  }

  UserDetails copyWith({String? updatedName, String? updatedId}) {
    return UserDetails(id: updatedId ?? id, name: updatedName ?? name);
  }
}
