import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter_instagram/repositories/repositories.dart';

import '../../config/paths.dart';
import '../../models/models.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    FirebaseFirestore? firebaseFirestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User?> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      _firebaseFirestore.collection(Paths.users).doc(user?.uid).set({
        'username': username,
        'email': email,
        'follower': 0,
        'following': 0,
      });
      return user;
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    } on auth.FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }

  @override
  Future<auth.User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    } on auth.FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
