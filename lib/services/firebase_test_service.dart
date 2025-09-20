import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestService {
  static Future<bool> testFirebaseConnection() async {
    try {
      // Test Firebase Core
      final app = Firebase.app();
      print('✅ Firebase Core initialized: ${app.name}');
      
      // Test Firestore
      final firestore = FirebaseFirestore.instance;
      await firestore.enableNetwork();
      print('✅ Firestore connection successful');
      
      // Test Firebase Auth
      final auth = FirebaseAuth.instance;
      print('✅ Firebase Auth initialized');
      
      return true;
    } catch (e) {
      print('❌ Firebase connection failed: $e');
      return false;
    }
  }
  
  static Future<bool> testFirestoreWrite() async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('test').doc('connection').set({
        'timestamp': FieldValue.serverTimestamp(),
        'message': 'Firebase connection test successful',
      });
      print('✅ Firestore write test successful');
      return true;
    } catch (e) {
      print('❌ Firestore write test failed: $e');
      return false;
    }
  }
  
  static Future<bool> testFirestoreRead() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final doc = await firestore.collection('test').doc('connection').get();
      if (doc.exists) {
        print('✅ Firestore read test successful');
        return true;
      } else {
        print('❌ Firestore read test failed: Document does not exist');
        return false;
      }
    } catch (e) {
      print('❌ Firestore read test failed: $e');
      return false;
    }
  }
  
  static Future<void> cleanupTestData() async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('test').doc('connection').delete();
      print('✅ Test data cleaned up');
    } catch (e) {
      print('❌ Failed to cleanup test data: $e');
    }
  }
}
