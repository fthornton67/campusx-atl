import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campusx_atl/ui/views/auth/sign_in_view.dart';
import 'package:campusx_atl/ui/views/auth/loading_view.dart';
import 'package:campusx_atl/ui/views/marketplace/marketplace_view.dart';
import 'package:campusx_atl/ui/views/debug/debug_view.dart';
import 'package:campusx_atl/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      return authState.when(
        data: (user) {
          final isAuthenticated = user != null;
          final isAuthRoute = state.uri.path == '/auth';
          final isDebugRoute = state.uri.path == '/debug';
          final isLoadingRoute = state.uri.path == '/loading';
          
          if (!isAuthenticated && !isAuthRoute && !isDebugRoute) {
            return '/auth';
          }
          
          if (isAuthenticated && (isAuthRoute || isLoadingRoute)) {
            return '/';
          }
          
          return null;
        },
        loading: () => '/loading', // Show loading screen
        error: (_, __) => '/auth', // Show auth screen on error
      );
    },
    routes: <GoRoute>[
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) => const LoadingView(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/debug',
        name: 'debug',
        builder: (context, state) => const DebugView(),
      ),
      GoRoute(
        path: '/',
        name: 'marketplace',
        builder: (context, state) => const MarketplaceView(),
      ),
    ],
  );
});

class CampusXApp extends ConsumerWidget {
  const CampusXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'CampusXATL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2A6EF2)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

