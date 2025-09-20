import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';
import '../../../models/user.dart' as app_models;

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'CampusXATL',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Sign in to connect with your GSU community'),
              const SizedBox(height: 32),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'GSU Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() => isLoading = true);
                          try {
                            final authService = ref.read(authServiceProvider);
                            await authService.signInWithEmailAndPassword(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                            // Navigation will be handled automatically by the router
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sign in failed: $e')),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() => isLoading = false);
                            }
                          }
                        },
                  child: Text(isLoading ? 'Signing in...' : 'Sign In'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() => isLoading = true);
                          try {
                            final authService = ref.read(authServiceProvider);
                            await authService.signInWithGoogle();
                            // Navigation will be handled automatically by the router
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Google sign in failed: $e')),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() => isLoading = false);
                            }
                          }
                        },
                  child: Text(isLoading ? 'Signing in...' : 'Continue with Google'),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("Don't have an account? Sign up"),
              ),
              const SizedBox(height: 16),
              // Temporary skip button for development
              TextButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        try {
                          final authService = ref.read(authServiceProvider);
                          await authService.createUserWithEmailAndPassword(
                            email: 'test@gsu.edu',
                            password: 'password123',
                            firstName: 'Test',
                            lastName: 'User',
                            userType: app_models.UserType.student,
                            studentId: '123456789',
                            major: 'Computer Science',
                          );
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Account creation failed: $e')),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => isLoading = false);
                          }
                        }
                      },
                child: Text(isLoading ? 'Creating...' : 'Create Test Account'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.go('/debug');
                },
                child: const Text('Debug Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

