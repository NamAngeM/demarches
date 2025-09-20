import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../../domain/entities/user_profile.dart';

// Provider pour le service d'authentification
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Provider pour l'utilisateur Firebase actuel
final firebaseUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Provider pour le profil utilisateur
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getUserProfile();
});

// Provider pour l'état de connexion
final isSignedInProvider = Provider<bool>((ref) {
  final user = ref.watch(firebaseUserProvider);
  return user.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});

// Provider pour l'ID utilisateur
final userIdProvider = Provider<String?>((ref) {
  final user = ref.watch(firebaseUserProvider);
  return user.when(
    data: (user) => user?.uid,
    loading: () => null,
    error: (_, __) => null,
  );
});

// Provider pour l'état de chargement de l'authentification
final authLoadingProvider = StateProvider<bool>((ref) => false);

// Provider pour les erreurs d'authentification
final authErrorProvider = StateProvider<String?>((ref) => null);

// Notifier pour la gestion de l'authentification
class AuthNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final AuthService _authService;
  final Ref _ref;

  AuthNotifier(this._authService, this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((user) async {
      if (user != null) {
        try {
          final profile = await _authService.getUserProfile();
          state = AsyncValue.data(profile);
        } catch (e) {
          state = AsyncValue.error(e, StackTrace.current);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;
      
      await _authService.signInWithGoogle();
      
      // Le profil sera mis à jour automatiquement via le stream
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> signInAnonymously() async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;
      
      await _authService.signInAnonymously();
      
      // Le profil sera mis à jour automatiquement via le stream
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> signOut() async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;
      
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    try {
      _ref.read(authErrorProvider.notifier).state = null;
      await _authService.updateUserProfile(profile);
      
      // Mettre à jour l'état local
      state = AsyncValue.data(profile);
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
    }
  }

  void clearError() {
    _ref.read(authErrorProvider.notifier).state = null;
  }
}

// Provider pour le notifier d'authentification
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserProfile?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService, ref);
});
