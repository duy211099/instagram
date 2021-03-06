import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/config/paths.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/repositories/repositories.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUserWithId(String userId) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser(User user) async {
    await _firebaseFirestore
        .collection('user')
        .doc(user.id)
        .update(user.toDocument());
  }
}
