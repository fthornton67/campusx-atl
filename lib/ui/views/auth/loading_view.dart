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
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // If still loading after 5 seconds, redirect to auth
        context.go('/auth');
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
            if (user != null) {
              context.go('/');
            } else {
              context.go('/auth');
            }
          }
        },
        loading: () {
          // Keep showing loading
        },
        error: (error, stack) {
          if (mounted) {
            context.go('/auth');
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
