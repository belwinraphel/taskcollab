import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel?> get authUserStream;
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String displayName);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> updateFcmToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);
  
  @override
  Stream<UserModel?> get authUserStream {
    return firebaseAuth.idTokenChanges().map((user) {
      if (user == null) {
        return null;
      }
      return UserModel.fromFirebase(user);
    });
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user == null) {
        throw Exception('User not found');
      }

      final user = userCredential.user!;
      final userDocRef = firestore.collection('users').doc(user.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
 
        await userDocRef.set({
          'email': user.email,
          'displayName': user.displayName,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
          'email_lowercase': user.email?.toLowerCase(),
          'displayName_lowercase': user.displayName?.toLowerCase(),
        });
      } else {
        // Update lastLoginAt
        await userDocRef.update({
          'lastLoginAt': FieldValue.serverTimestamp(),
        });
      }

      return UserModel.fromFirebase(user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> register(
      String email, String password, String displayName) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw Exception('User creation failed');
      }
      
      final user = userCredential.user!;

      // Update Firebase User Profile
      await user.updateDisplayName(displayName);

      // Create user doc in Firestore
      await firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'email_lowercase': user.email?.toLowerCase(),
        'displayName_lowercase': displayName.toLowerCase(),
      });

      return UserModel.fromFirebase(user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<void> updateFcmToken(String token) async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'fcmToken': token}, SetOptions(merge: true));
    }
  }
}
