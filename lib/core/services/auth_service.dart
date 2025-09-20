import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream de l'utilisateur actuel
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Utilisateur actuel
  User? get currentUser => _auth.currentUser;

  // Connexion avec Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Déclencher le flux d'authentification Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return null; // L'utilisateur a annulé la connexion
      }

      // Obtenir les détails d'authentification
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Créer un nouveau credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Se connecter avec Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Créer ou mettre à jour le profil utilisateur
      await _createOrUpdateUserProfile(userCredential.user!);
      
      return userCredential;
    } catch (e) {
      throw Exception('Erreur lors de la connexion Google: $e');
    }
  }

  // Connexion anonyme
  Future<UserCredential?> signInAnonymously() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      await _createOrUpdateUserProfile(userCredential.user!);
      return userCredential;
    } catch (e) {
      throw Exception('Erreur lors de la connexion anonyme: $e');
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Erreur lors de la déconnexion: $e');
    }
  }

  // Supprimer le compte
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Supprimer les données Firestore
        await _firestore.collection('users').doc(user.uid).delete();
        
        // Supprimer le compte Firebase
        await user.delete();
      }
    } catch (e) {
      throw Exception('Erreur lors de la suppression du compte: $e');
    }
  }

  // Créer ou mettre à jour le profil utilisateur
  Future<void> _createOrUpdateUserProfile(User user) async {
    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      
      if (!userDoc.exists) {
        // Créer un nouveau profil
        final userProfile = UserProfile(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? 'Utilisateur',
          photoUrl: user.photoURL,
          countryOfOrigin: '',
          university: '',
          level: UserLevel.bachelor,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isFirstTime: true,
        );
        
        await _firestore.collection('users').doc(user.uid).set(userProfile.toJson());
      } else {
        // Mettre à jour les informations de base
        await _firestore.collection('users').doc(user.uid).update({
          'email': user.email,
          'displayName': user.displayName,
          'photoUrl': user.photoURL,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Erreur lors de la création/mise à jour du profil: $e');
    }
  }

  // Obtenir le profil utilisateur
  Future<UserProfile?> getUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserProfile.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Erreur lors de la récupération du profil: $e');
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Utilisateur non connecté');

      await _firestore.collection('users').doc(user.uid).update({
        ...profile.toJson(),
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du profil: $e');
    }
  }

  // Vérifier si l'utilisateur est connecté
  bool get isSignedIn => _auth.currentUser != null;

  // Obtenir l'ID de l'utilisateur
  String? get userId => _auth.currentUser?.uid;
}
