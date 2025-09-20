# Firebase Setup Guide for CampusXATL

This guide will help you set up Firebase for your CampusXATL Flutter app.

## Prerequisites
- Google account
- Flutter SDK installed
- Android Studio (for Android development)
- Xcode (for iOS development)

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `campusx-atl`
4. Enable Google Analytics (recommended)
5. Choose or create a Google Analytics account
6. Click "Create project"

## Step 2: Add Android App

1. In your Firebase project, click "Add app" and select Android
2. Enter package name: `com.campusx_atl`
3. Enter app nickname: `CampusXATL Android`
4. Enter SHA-1 fingerprint (optional for now):
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
5. Click "Register app"
6. Download `google-services.json` and replace the placeholder file at:
   `android/app/google-services.json`

## Step 3: Add iOS App

1. In your Firebase project, click "Add app" and select iOS
2. Enter bundle ID: `com.campusx_atl`
3. Enter app nickname: `CampusXATL iOS`
4. Enter App Store ID (optional)
5. Click "Register app"
6. Download `GoogleService-Info.plist` and replace the placeholder file at:
   `ios/Runner/GoogleService-Info.plist`

## Step 4: Enable Firebase Services

### Authentication
1. Go to Authentication > Sign-in method
2. Enable the following providers:
   - Email/Password
   - Google Sign-In
   - Phone (optional)

### Firestore Database
1. Go to Firestore Database
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location (choose closest to your users)

### Storage
1. Go to Storage
2. Click "Get started"
3. Choose "Start in test mode" (for development)
4. Select a location (same as Firestore)

### Cloud Functions (Optional)
1. Go to Functions
2. Click "Get started"
3. Follow the setup instructions for your preferred region

## Step 5: Update Firebase Configuration

After downloading the configuration files, update `lib/firebase_options.dart` with your actual values:

1. Open `lib/firebase_options.dart`
2. Replace all placeholder values with actual values from your Firebase project:
   - `your-web-api-key` → Your Web API key
   - `your-android-api-key` → Your Android API key
   - `your-ios-api-key` → Your iOS API key
   - `your-web-app-id` → Your Web App ID
   - `your-android-app-id` → Your Android App ID
   - `your-ios-app-id` → Your iOS App ID
   - `your-messaging-sender-id` → Your Messaging Sender ID
   - `your-measurement-id` → Your Measurement ID (for Analytics)

## Step 6: Test Firebase Connection

1. Run the app:
   ```bash
   flutter run
   ```

2. Check the console for any Firebase initialization errors

3. Test authentication by trying to sign in

## Step 7: Security Rules (Important!)

### Firestore Rules
Update your Firestore rules in the Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Services are readable by all authenticated users
    match /services/{serviceId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == resource.data.providerId;
    }
    
    // Orders are readable by the customer and provider
    match /orders/{orderId} {
      allow read, write: if request.auth != null && 
        (request.auth.uid == resource.data.customerId || 
         request.auth.uid == resource.data.providerId);
    }
    
    // Messages are readable by participants
    match /messages/{messageId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participants;
    }
  }
}
```

### Storage Rules
Update your Storage rules:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /services/{serviceId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == resource.metadata.providerId;
    }
  }
}
```

## Step 8: Environment Variables (Optional)

For production, consider using environment variables for sensitive data:

1. Create a `.env` file in your project root
2. Add your Firebase configuration:
   ```
   FIREBASE_API_KEY=your_api_key
   FIREBASE_PROJECT_ID=campusx-atl
   FIREBASE_MESSAGING_SENDER_ID=your_sender_id
   ```

3. Use the `flutter_dotenv` package to load these values

## Troubleshooting

### Common Issues:

1. **"Firebase not initialized" error**
   - Make sure `google-services.json` and `GoogleService-Info.plist` are in the correct locations
   - Check that the package name/bundle ID matches exactly

2. **Build errors on Android**
   - Make sure Google Services plugin is applied in `android/app/build.gradle.kts`
   - Clean and rebuild: `flutter clean && flutter pub get && flutter run`

3. **Build errors on iOS**
   - Make sure `GoogleService-Info.plist` is added to Xcode project
   - Clean and rebuild: `flutter clean && flutter pub get && flutter run`

4. **Authentication not working**
   - Check that the SHA-1 fingerprint is added to Firebase Console
   - Verify that the authentication providers are enabled

## Next Steps

After Firebase is set up:

1. Test all authentication methods
2. Test Firestore read/write operations
3. Test file uploads to Storage
4. Set up push notifications
5. Configure analytics and crash reporting

## Support

If you encounter issues:
1. Check the [Firebase Flutter documentation](https://firebase.flutter.dev/)
2. Check the [Firebase Console](https://console.firebase.google.com/) for error logs
3. Review the Flutter console output for detailed error messages
