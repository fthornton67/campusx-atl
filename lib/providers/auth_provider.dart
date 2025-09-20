import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:campusx_atl/models/user.dart' as app_models;
import 'package:campusx_atl/services/mock_auth_service.dart';

final authServiceProvider = Provider<MockAuthService>((ref) => MockAuthService());

final authStateProvider = StreamProvider<firebase_auth.User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  // Start with a null value immediately, then listen to the stream
  return Stream.value(null).asyncExpand((_) {
    try {
      return authService.authStateChanges;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error in authStateProvider: $e');
      }
      return Stream.value(null);
    }
  });
});

final currentUserProvider = FutureProvider<app_models.User?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getCurrentUserData();
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});
