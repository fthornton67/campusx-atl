import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campusx_atl/firebase_options.dart';
import 'package:campusx_atl/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      debugPrint('Firebase initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Firebase initialization failed: $e');
    }
    // Continue anyway for development
  }

  // Add error handling for unhandled exceptions
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      debugPrint('Flutter Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
    }
  };

  // Add error handling for platform errors
  ServicesBinding.instance.platformDispatcher.onError = (error, stack) {
    if (kDebugMode) {
      debugPrint('Platform Error: $error');
      debugPrint('Stack trace: $stack');
    }
    return true;
  };

  try {
    // Configure Stripe using compile-time environment variables
    // Pass with: --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx --dart-define=STRIPE_MERCHANT_IDENTIFIER=merchant.com.campusx.atl --dart-define=STRIPE_URL_SCHEME=campusxatl
    final publishableKey = const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');
    final merchantId = const String.fromEnvironment('STRIPE_MERCHANT_IDENTIFIER', defaultValue: 'merchant.com.campusx.atl');
    final urlScheme = const String.fromEnvironment('STRIPE_URL_SCHEME', defaultValue: 'campusxatl');
    if (publishableKey.isNotEmpty) {
      Stripe.publishableKey = publishableKey;
      Stripe.merchantIdentifier = merchantId;
      await Stripe.instance.applySettings();
    }
    if (Platform.isIOS && urlScheme.isNotEmpty) {
      // iOS: ensure URL scheme is added to Info.plist matching this value
    }

    runApp(const ProviderScope(child: CampusXApp()));
  } catch (e, stackTrace) {
    if (kDebugMode) {
      debugPrint('Error in main: $e');
      debugPrint('Stack trace: $stackTrace');
    }
    rethrow;
  }
}
