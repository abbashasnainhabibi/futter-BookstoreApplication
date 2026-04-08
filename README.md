# Bookstore App

A modern Flutter mobile application for browsing, purchasing, and managing books with real-time Firebase backend integration.

## 📱 Overview

Bookstore App is a full-featured e-commerce application built with Flutter and Firebase, designed to provide users with a seamless shopping experience for books. The application features robust authentication, dynamic product management, and an intuitive admin panel for inventory control.

## ✨ Features

### User Features
- **Authentication System**
  - Sign up with email and password
  - Google Sign-In integration
  - Password reset functionality via email
  - Strong password validation with security requirements
  
- **Product Browsing**
  - View all available books with detailed information
  - Search and filter functionality
  - Browse books by category
  - View book details including description, author, and price

- **Shopping Cart**
  - Add books to shopping cart
  - Manage cart items (add, remove, update quantity)
  - View cart total and proceed to checkout
  - Persistent cart storage

- **Bestsellers Section**
  - View trending and recently added books
  - Discover popular titles at a glance

### Admin Panel Features
- **Book Management**
  - Add new books with complete details (title, author, price, description, cover image)
  - Edit existing book information
  - Delete books from inventory
  - Upload and manage book cover images

- **Category Management**
  - Create and manage book categories
  - Organize books by genre and category

- **Analytics Dashboard**
  - View inventory statistics
  - Monitor bestsellers and recent additions
  - Track product performance

## 🛠 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Firestore Database
  - Firebase Authentication
  - Firebase Storage (for book cover images)
- **IDE**: Android Studio / VS Code
- **Version Control**: Git

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (version 2.0 or higher)
- Dart SDK (included with Flutter)
- Android Studio or Xcode (for running on emulator/device)
- Git
- A Firebase project (for backend integration)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/bookstore-app.git
cd bookstore-app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration

#### For Android:
- Download `google-services.json` from Firebase Console
- Place it in `android/app/`
- Update `android/build.gradle` with Google Services plugin

#### For iOS:
- Download `GoogleService-Info.plist` from Firebase Console
- Add it to Xcode project (iOS Runner target)
- Update iOS Runner settings as per Firebase iOS setup guide

### 4. Configure Firebase in your project:
- Update `lib/config/firebase_config.dart` with your Firebase project credentials

### 5. Run the Application
```bash
flutter run
```

## 📖 Usage

### For Users
1. **Create Account or Login**: Sign up with email or Google, create a strong password
2. **Browse Books**: Search, filter by category, or view bestsellers
3. **Purchase**: Add books to cart and proceed to checkout

### For Admins
1. **Access Admin Panel**: Log in with admin credentials
2. **Manage Books**: Add, edit, or delete books with full details
3. **Manage Categories**: Create and organize book categories
4. **View Analytics**: Monitor bestsellers and inventory

## 🔐 Security Features

- Strong password validation (min 8 chars, uppercase, lowercase, numbers, special characters)
- Secure Firebase authentication
- Encrypted password storage
- Email verification for password reset

## 📁 Project Structure
bookstore-app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── product/
│   │   ├── cart/
│   │   └── admin/
│   ├── models/
│   ├── services/
│   └── config/
├── android/
├── ios/
└── pubspec.yaml

## 🧪 Testing

```bash
flutter test
```

## 📦 Build for Release

### Android:
```bash
flutter build apk --release
```

### iOS:
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

- **Firebase Connection Issues**: Ensure google-services.json is properly placed
- **Image Upload Failures**: Check Firebase Storage permissions
- **Authentication Errors**: Verify Firebase Authentication methods are enabled

## 📝 License

Proprietary - All rights reserved.

## 👨‍💼 Author

Abbas

---

**Note**: Portfolio project demonstrating Flutter and Firebase expertise.
