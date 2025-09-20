import 'package:flutter/foundation.dart';
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
    initialLocation: '/loading',
    redirect: (context, state) {
      if (kDebugMode) {
        debugPrint('Router redirect: current path = ${state.uri.path}, authState = ${authState.runtimeType}');
      }
      
      return authState.when(
        data: (user) {
          final isAuthenticated = user != null;
          final isAuthRoute = state.uri.path == '/auth';
          final isDebugRoute = state.uri.path == '/debug';
          final isLoadingRoute = state.uri.path == '/loading';
          final isHomeRoute = state.uri.path == '/';
          
          if (kDebugMode) {
            debugPrint('Router redirect: data state - isAuthenticated=$isAuthenticated, isAuthRoute=$isAuthRoute, isDebugRoute=$isDebugRoute, isLoadingRoute=$isLoadingRoute, isHomeRoute=$isHomeRoute');
          }
          
          // If on loading page, redirect to home (allow anonymous access)
          if (isLoadingRoute) {
            if (kDebugMode) {
              debugPrint('Router redirect: redirecting from loading to home (anonymous access allowed)');
            }
            return '/';
          }
          
          // If authenticated and on auth page, go to home
          if (isAuthenticated && isAuthRoute) {
            if (kDebugMode) {
              debugPrint('Router redirect: redirecting to / (authenticated user on auth page)');
            }
            return '/';
          }
          
          // No redirect needed - allow access to all pages
          if (kDebugMode) {
            debugPrint('Router redirect: no redirect needed');
          }
          return null;
        },
        loading: () {
          // If already on loading page, stay there
          if (state.uri.path == '/loading') {
            if (kDebugMode) {
              debugPrint('Router redirect: staying on loading page');
            }
            return null;
          }
          if (kDebugMode) {
            debugPrint('Router redirect: redirecting to /loading (loading state)');
          }
          return '/loading';
        },
        error: (error, stack) {
          if (kDebugMode) {
            debugPrint('Router redirect: error state - $error');
          }
          return '/auth'; // Show auth screen on error
        },
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

