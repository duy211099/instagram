import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileUrl;
  final int followers;
  final int following;
  final String bio;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.profileUrl,
    required this.followers,
    required this.following,
    required this.bio,
  });

  static const empty = User(
    id: 'id',
    username: '',
    email: '',
    profileUrl: '',
    followers: 0,
    following: 0,
    bio: '',
  );

  @override
  List<Object> get props {
    return [
      id,
      username,
      email,
      profileUrl,
      followers,
      following,
      bio,
    ];
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileUrl,
    int? followers,
    int? following,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileUrl: profileUrl ?? this.profileUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toDocument() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'profileUrl': profileUrl});
    result.addAll({'followers': followers});
    result.addAll({'following': following});
    result.addAll({'bio': bio});

    return result;
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, profileUrl: $profileUrl, followers: $followers, following: $following, bio: $bio)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'profileUrl': profileUrl});
    result.addAll({'followers': followers});
    result.addAll({'following': following});
    result.addAll({'bio': bio});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      followers: map['followers']?.toInt() ?? 0,
      following: map['following']?.toInt() ?? 0,
      bio: map['bio'] ?? '',
    );
  }

  factory User.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      id: doc.id,
      username: doc['username'] ?? '',
      email: doc.data()?['email'] ?? '',
      profileUrl: doc.data()?['profileUrl'] ?? '',
      followers: doc.data()?['followers']?.toInt() ?? 0,
      following: doc.data()?['following']?.toInt() ?? 0,
      bio: doc.data()?['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
