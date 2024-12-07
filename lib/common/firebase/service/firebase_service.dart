import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';

abstract class FirebaseService {
  // along with auth users
  Future<Either<String, dynamic>> createDocument(String collection, Map<String, dynamic> data);
  Future<Either<String, String>> createDocuments(String collection, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getDocument(String collection, String id);
  Future<List<Map<String, dynamic>>> getAllDocuments(String collection);
  Future<void> updateDocument(
      String collection, String id, Map<String, dynamic> data);
  Future<void> deleteDocument(String collection, String id);
}
