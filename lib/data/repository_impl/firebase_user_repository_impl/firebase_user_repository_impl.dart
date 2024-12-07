import 'package:dartz/dartz.dart';
import 'package:todo_app/common/firebase/service/firebase_service.dart';
import 'package:todo_app/data/user_dto/UserDto.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';
import 'package:todo_app/domain/repository/user_repository/user_repository.dart';

// class FirebaseUserRepository extends UserRepository {
//   final FirebaseFirestore _firestore;
//
//   FirebaseUserRepository(this._firestore);
//
//   @override
//   Future<String> createUser(User user) async {
//     try {
//       UserDto userDTO = UserDto.fromDomain(user);
//       DocumentReference docRef =
//       await _firestore.collection('users').add(userDTO.toMap());
//       return docRef.id;
//     } catch (e) {
//       throw Exception('Failed to create user: $e');
//     }
//   }
//
//   @override
//   Future<User?> getUserById(String id) async {
//     try {
//       DocumentSnapshot doc =
//       await _firestore.collection('users').doc(id).get();
//       if (doc.exists) {
//         return UserDto.fromMap(doc.data() as Map<String, dynamic>, doc.id)
//             .toDomain();
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Failed to get user: $e');
//     }
//   }
//
//   @override
//   Future<List<User>> getAllUsers() async {
//     try {
//       QuerySnapshot snapshot = await _firestore.collection('users').get();
//       return snapshot.docs
//           .map((doc) => UserDto.fromMap(doc.data() as Map<String, dynamic>, doc.id)
//           .toDomain())
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get all users: $e');
//     }
//   }
//
//   @override
//   Future<void> updateUser(User user) async {
//     try {
//       UserDto userDTO = UserDto.fromDomain(user);
//       await _firestore
//           .collection('users')
//           .doc(user.id)
//           .update(userDTO.toMap());
//     } catch (e) {
//       throw Exception('Failed to update user: $e');
//     }
//   }
//
//   @override
//   Future<void> deleteUser(String id) async {
//     try {
//       await _firestore.collection('users').doc(id).delete();
//     } catch (e) {
//       throw Exception('Failed to delete user: $e');
//     }
//   }
// }

class FirebaseUserRepository implements UserRepository {
  final FirebaseService _firebaseService = getInstance<FirebaseService>();

  // FirebaseUserRepository(this._firebaseService);

  @override
  Future<Either<String, UserEntity>> createUser(UserEntity user) async {
    try {
      UserDto userDTO = UserDto.fromDomain(user);
      final result =
          await _firebaseService.createDocument('users', userDTO.toMap());

         return result.fold (
                  (l) => const Left("Failed to create User"),
              (r) {
                  final registered =  user.copyWith(
                      id: r,

                    );
                     return Right(registered);
              }

        );

    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<UserEntity?> getUserById(String id) async {
    try {
      Map<String, dynamic>? data =
          await _firebaseService.getDocument('users', id);
      return data != null ? UserDto.fromMap(data, id).toDomain() : null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    try {
      List<Map<String, dynamic>> data =
          await _firebaseService.getAllDocuments('users');
      return data
          .map((map) => UserDto.fromMap(map, map['id']).toDomain())
          .toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      UserDto userDTO = UserDto.fromDomain(user);
      await _firebaseService.updateDocument('users', user.id, userDTO.toMap());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await _firebaseService.deleteDocument('users', id);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
