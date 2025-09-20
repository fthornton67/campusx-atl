import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:campusx_atl/models/user.dart' as app_models;

class MockAuthService {
  final StreamController<firebase_auth.User?> _authStateController = StreamController<firebase_auth.User?>.broadcast();
  firebase_auth.User? _currentUser;
  
  MockAuthService() {
    // Emit initial state (null = not authenticated) after a small delay
    // to simulate async behavior
    Future.microtask(() {
      _authStateController.add(null);
    });
  }
  
  firebase_auth.User? get currentUser => _currentUser;
  Stream<firebase_auth.User?> get authStateChanges => _authStateController.stream;

  Future<firebase_auth.User?> signInWithEmailAndPassword(String email, String password) async {
    // Mock implementation - always succeeds
    await Future.delayed(const Duration(seconds: 1));
    
    // Create a mock user
    final mockUser = MockFirebaseUser(
      uid: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
    );
    
    _currentUser = mockUser;
    _authStateController.add(mockUser);
    return mockUser;
  }

  Future<firebase_auth.User?> signInWithGoogle() async {
    // Mock implementation - always succeeds
    await Future.delayed(const Duration(seconds: 1));
    
    // Create a mock user
    final mockUser = MockFirebaseUser(
      uid: 'mock_google_user_${DateTime.now().millisecondsSinceEpoch}',
      email: 'test@gmail.com',
    );
    
    _currentUser = mockUser;
    _authStateController.add(mockUser);
    return mockUser;
  }

  Future<void> signOut() async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
  }

  Future<firebase_auth.User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required app_models.UserType userType,
    String? studentId,
    String? major,
  }) async {
    // Mock implementation - always succeeds
    await Future.delayed(const Duration(seconds: 1));
    
    // Create a mock user
    final mockUser = MockFirebaseUser(
      uid: 'mock_new_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
    );
    
    _currentUser = mockUser;
    _authStateController.add(mockUser);
    return mockUser;
  }

  Future<app_models.User?> getCurrentUserData() async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    
    return app_models.User(
      id: 'mock_user_123',
      email: 'test@gsu.edu',
      firstName: 'Test',
      lastName: 'User',
      userType: app_models.UserType.student,
      studentId: '123456789',
      major: 'Computer Science',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<void> updateUserProfile(app_models.User user) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void dispose() {
    _authStateController.close();
  }
}

// Simple mock Firebase User class
class MockFirebaseUser implements firebase_auth.User {
  @override
  final String uid;
  
  @override
  final String? email;
  
  @override
  final String? displayName;
  
  @override
  final String? photoURL;
  
  @override
  final bool emailVerified = true;
  
  @override
  final bool isAnonymous = false;
  
  @override
  final firebase_auth.UserMetadata metadata = MockUserMetadata();
  
  @override
  final firebase_auth.MultiFactor multiFactor = MockMultiFactor();
  
  @override
  final String? phoneNumber = null;
  
  @override
  final List<firebase_auth.UserInfo> providerData = [];
  
  @override
  final String? refreshToken = null;
  
  @override
  final String? tenantId = null;
  
  MockFirebaseUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
  
  @override
  Future<void> delete() async {}
  
  @override
  Future<String> getIdToken([bool forceRefresh = false]) async => 'mock_token';
  
  @override
  Future<firebase_auth.IdTokenResult> getIdTokenResult([bool forceRefresh = false]) async {
    return MockIdTokenResult();
  }
  
  @override
  Future<firebase_auth.UserCredential> linkWithCredential(firebase_auth.AuthCredential credential) async {
    return MockUserCredential();
  }
  
  @override
  Future<firebase_auth.UserCredential> linkWithProvider(firebase_auth.AuthProvider provider) async {
    return MockUserCredential();
  }
  
  @override
  Future<firebase_auth.UserCredential> linkWithPopup(firebase_auth.AuthProvider provider) async {
    return MockUserCredential();
  }
  
  @override
  Future<void> linkWithRedirect(firebase_auth.AuthProvider provider) async {}
  
  @override
  Future<firebase_auth.ConfirmationResult> linkWithPhoneNumber(String phoneNumber, [firebase_auth.RecaptchaVerifier? verifier]) async {
    return MockConfirmationResult();
  }
  
  @override
  Future<firebase_auth.UserCredential> reauthenticateWithCredential(firebase_auth.AuthCredential credential) async {
    return MockUserCredential();
  }
  
  @override
  Future<firebase_auth.UserCredential> reauthenticateWithProvider(firebase_auth.AuthProvider provider) async {
    return MockUserCredential();
  }
  
  @override
  Future<firebase_auth.UserCredential> reauthenticateWithPopup(firebase_auth.AuthProvider provider) async {
    return MockUserCredential();
  }
  
  @override
  Future<void> reauthenticateWithRedirect(firebase_auth.AuthProvider provider) async {}
  
  Future<firebase_auth.UserCredential> reauthenticateWithPhoneNumber(String phoneNumber, [firebase_auth.RecaptchaVerifier? verifier]) async {
    return MockUserCredential();
  }
  
  @override
  Future<void> reload() async {}
  
  @override
  Future<void> sendEmailVerification([firebase_auth.ActionCodeSettings? actionCodeSettings]) async {}
  
  @override
  Future<firebase_auth.User> unlink(String providerId) async {
    return this;
  }
  
  @override
  Future<void> updateDisplayName(String? displayName) async {}
  
  @override
  Future<void> updateEmail(String newEmail) async {}
  
  @override
  Future<void> updatePassword(String newPassword) async {}
  
  @override
  Future<void> updatePhoneNumber(firebase_auth.PhoneAuthCredential phoneCredential) async {}
  
  @override
  Future<void> updatePhotoURL(String? photoURL) async {}
  
  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) async {}
  
  @override
  Future<void> verifyBeforeUpdateEmail(String newEmail, [firebase_auth.ActionCodeSettings? actionCodeSettings]) async {}
}

// Simple mock classes for Firebase User dependencies
class MockUserMetadata implements firebase_auth.UserMetadata {
  @override
  final DateTime creationTime = DateTime.now();
  
  @override
  final DateTime lastSignInTime = DateTime.now();
}

class MockMultiFactor implements firebase_auth.MultiFactor {
  List<firebase_auth.MultiFactorInfo> get enrolledFactors => [];
  
  @override
  Future<List<firebase_auth.MultiFactorInfo>> getEnrolledFactors() async => [];
  
  @override
  Future<firebase_auth.MultiFactorSession> getSession() async {
    return MockMultiFactorSession();
  }
  
  Future<firebase_auth.PhoneMultiFactorGenerator> getPhoneNumberGenerator() async {
    return MockPhoneMultiFactorGenerator();
  }
  
  Future<firebase_auth.TotpMultiFactorGenerator> getTotpGenerator() async {
    return MockTotpMultiFactorGenerator();
  }
  
  @override
  Future<void> enroll(firebase_auth.MultiFactorAssertion assertion, {String? displayName}) async {}
  
  @override
  Future<void> unenroll({String? factorUid, firebase_auth.MultiFactorInfo? multiFactorInfo}) async {}
}

class MockIdTokenResult implements firebase_auth.IdTokenResult {
  @override
  String get token => 'mock_token';
  
  @override
  DateTime get authTime => DateTime.now();
  
  @override
  DateTime get issuedAtTime => DateTime.now();
  
  @override
  DateTime get expirationTime => DateTime.now().add(const Duration(hours: 1));
  
  @override
  String? get signInProvider => 'password';
  
  @override
  Map<String, dynamic> get claims => {};
  
  String? get signInSecondFactor => null;
}

class MockUserCredential implements firebase_auth.UserCredential {
  @override
  firebase_auth.User? get user => null;
  
  @override
  firebase_auth.AdditionalUserInfo? get additionalUserInfo => null;
  
  @override
  firebase_auth.AuthCredential? get credential => null;
}

class MockConfirmationResult implements firebase_auth.ConfirmationResult {
  @override
  String get verificationId => 'mock_verification_id';
  
  @override
  Future<firebase_auth.UserCredential> confirm(String verificationCode) async {
    return MockUserCredential();
  }
}

class MockMultiFactorSession implements firebase_auth.MultiFactorSession {
  @override
  String get id => 'mock_session_id';
}

class MockPhoneMultiFactorGenerator implements firebase_auth.PhoneMultiFactorGenerator {
  Future<firebase_auth.MultiFactorAssertion> getAssertion(firebase_auth.PhoneAuthCredential credential) async {
    return MockMultiFactorAssertion();
  }
}

class MockTotpMultiFactorGenerator implements firebase_auth.TotpMultiFactorGenerator {
  Future<firebase_auth.TotpSecret> generateSecret() async {
    return MockTotpSecret();
  }
  
  Future<firebase_auth.MultiFactorAssertion> getAssertionForEnrollment(String secretKey, String oneTimePassword) async {
    return MockMultiFactorAssertion();
  }
  
  Future<firebase_auth.MultiFactorAssertion> getAssertionForSignIn(String secretKey, String oneTimePassword) async {
    return MockMultiFactorAssertion();
  }
}

class MockMultiFactorAssertion implements firebase_auth.MultiFactorAssertion {
  String get factorId => 'mock_factor_id';
}

class MockTotpSecret implements firebase_auth.TotpSecret {
  @override
  String get secretKey => 'mock_secret_key';
  
  String get qrCodeUrl => 'mock_qr_code_url';
  
  String get algorithm => 'SHA1';
  
  @override
  int get codeLength => 6;
  
  @override
  int get codeIntervalSeconds => 30;
  
  @override
  DateTime? get enrollmentCompletionDeadline => null;
  
  @override
  String? get hashingAlgorithm => 'SHA1';
  
  @override
  Future<String> generateQrCodeUrl({
    String? accountName,
    String? issuer,
  }) async => 'mock_qr_code_url';
  
  @override
  Future<void> openInOtpApp(
    String qrCodeUrl, {
    String? accountName,
    String? issuer,
  }) async {}
}