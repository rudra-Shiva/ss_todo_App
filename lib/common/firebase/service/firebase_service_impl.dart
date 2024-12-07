import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';

import 'firebase_service.dart';

class FirebaseServiceImpl extends FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseServiceImpl(this._firestore);
  @override
  Future<Either<String, dynamic>> createDocument(String collection, Map<String, dynamic> data) async {
    try {
      // Step 1: Extract email and password from the data map
      final String? email = data['email'];
      final String? password = data['password'];
      // Step 2: Validate extracted fields
      if (email == null || email.isEmpty) {
        return const Left('Email is required.');
      }
      if (password == null || password.isEmpty) {
        return const Left('Password is required.');
      }

      // Step 4: Create a user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user == null) {
        return const Left('Failed to create user in Firebase Authentication.');
      }

      // Step 5: Save user data to Firestore
      data['id'] = user.uid;
      await _firestore.collection(collection).doc(user.uid).set(data);
      print(user);

      // return result.fold(
      //       (failure) => Left(failure), // Pass the error string if creation fails
      //       (documentId) {
      //     // Update the UserEntity with the new document ID and return success
      //     final updatedUser = user.copyWith(id: documentId.toString());
      //     return Right(updatedUser);
      //   },
      // );
      // Step 6: Return the user ID on success
      return Right(user.uid);
      // DocumentReference docRef = await _firestore.collection(collection).add(data);
      // return Right( docRef.id.toString());
    } catch (e) {
      throw Left(Exception('Failed to create document: $e'));
    }
  }
  @override
  Future<Either<String, String>> createDocuments(String collection, Map<String, dynamic> data) async {
    try {
      DocumentReference docRef = await _firestore.collection(collection).add(data);
      return Right( docRef.id.toString());
    } catch (e) {
      throw Left(Exception('Failed to create document: $e'));
    }
  }

  @override
  Future<Map<String, dynamic>?> getDocument(String collection, String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(collection).doc(id).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      throw Exception('Failed to get document: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDocuments(String collection) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collection).get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Failed to get all documents: $e');
    }
  }

  @override
  Future<void> updateDocument(String collection, String id, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(id).update(data);
    } catch (e) {
      throw Exception('Failed to update document: $e');
    }
  }

  @override
  Future<void> deleteDocument(String collection, String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete document: $e');
    }
  }
}
