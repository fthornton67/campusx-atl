import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase. On iOS, if GoogleService-Info.plist is present,
  // default initialization without options works.
  await Firebase.initializeApp();

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
}
