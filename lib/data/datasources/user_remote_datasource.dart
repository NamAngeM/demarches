import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../../core/errors/exceptions.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<UserModel> getUserById(String userId);
  Future<UserModel> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firestore});

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      // This would typically get the current user ID from Firebase Auth
      // For now, we'll throw an exception as this needs to be implemented
      throw const AuthException(message: 'User not authenticated');
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Erreur Firebase');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(userId)
          .get();
      
      if (!doc.exists) {
        throw const ServerException(message: 'Utilisateur non trouvé');
      }
      
      return UserModel.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Erreur Firebase');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      await firestore
          .collection('users')
          .doc(user.id)
          .update(user.toJson());
      
      return user;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Erreur Firebase');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Erreur Firebase');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
