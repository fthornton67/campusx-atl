import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';

class LoadingView extends ConsumerStatefulWidget {
  const LoadingView({super.key});

  @override
  ConsumerState<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends ConsumerState<LoadingView> {
  @override
  void initState() {
    super.initState();
    // Add a timeout to prevent infinite loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // If still loading after 500ms, redirect to home (allow anonymous access)
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    
    // Listen to auth state changes and redirect accordingly
    ref.listen<AsyncValue<dynamic>>(authStateProvider, (previous, next) {
      next.when(
        data: (user) {
          if (mounted) {
            // Always redirect to home, regardless of authentication status
            context.go('/');
          }
        },
        loading: () {
          // Keep showing loading
        },
        error: (error, stack) {
          if (mounted) {
            // On error, still redirect to home (allow anonymous access)
            context.go('/');
          }
        },
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This may take a moment',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
