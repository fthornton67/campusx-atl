# CampusXATL

A Flutter-based marketplace app for campus services at Georgia State University, similar to Uber but for student-to-student services.

## Features

### For Students
- **Browse Services**: Discover various campus services including food delivery, laundry, tutoring, transportation, cleaning, maintenance, tech support, and printing
- **Real-time Tracking**: Track your service requests in real-time with live updates
- **Secure Payments**: Integrated Stripe payment processing for safe transactions
- **Chat System**: Communicate directly with service providers
- **Rating & Reviews**: Rate and review services to help the community

### For Service Providers
- **Service Management**: Create and manage your service offerings
- **Order Management**: Accept, track, and complete service requests
- **Earnings Tracking**: Monitor your earnings and performance
- **Profile Management**: Build your reputation with ratings and reviews

## Tech Stack

- **Frontend**: Flutter with Material Design 3
- **Backend**: Firebase (Firestore, Auth, Storage, Functions)
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Payments**: Stripe
- **Maps**: Google Maps Flutter
- **Real-time**: Firebase Realtime Database
- **Authentication**: Firebase Auth with Google Sign-In

## Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Firebase project setup
- Google Maps API key
- Stripe account

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Follow the detailed setup guide in `FIREBASE_SETUP.md`
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Update Firebase configuration in `lib/firebase_options.dart`

4. Configure Stripe:
   - Add your Stripe publishable key as a compile-time environment variable
   - Update merchant identifier and URL scheme

5. Run the app:
   ```bash
   flutter run
   ```

6. Test Firebase connection:
   - Navigate to the Debug view in the app
   - Use the Firebase test buttons to verify connection
   - Check console output for any errors

## Project Structure

```
lib/
├── app/                 # App configuration and routing
├── models/              # Data models (User, Service, Order, Message)
├── services/            # Business logic and API services
└── ui/
    └── views/           # UI screens
        ├── auth/        # Authentication screens
        ├── marketplace/ # Main marketplace interface
        ├── orders/      # Order management
        ├── chat/        # Messaging system
        └── profile/     # User profile management
```

## Contributing

This project is designed for Georgia State University students. Contributions are welcome!

## License

This project is licensed under the MIT License.
