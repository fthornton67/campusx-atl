import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/views/auth/sign_in_view.dart';
import '../ui/views/home/home_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth',
    routes: <GoRoute>[
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeView(),
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

