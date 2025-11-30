# BrainGuard - Recovery & Mental Wellness App

[![Flutter](https://img.shields.io/badge/Flutter-3.7.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Private-red)]()

> A comprehensive addiction recovery and mental wellness application built with Flutter, featuring AI-powered coaching, community support, and scientifically-backed recovery tools.

---

## 📱 About The Project

**BrainGuard** is a holistic recovery companion designed to help individuals overcome pornography addiction and build healthier mental habits. The app combines evidence-based recovery techniques with modern technology to provide 24/7 support, tracking, and motivation.

### 🎯 Mission
To empower individuals on their recovery journey through accessible, privacy-first tools that promote mental clarity, emotional wellness, and lasting behavioral change.

---

## ✨ Key Features

### 🏆 Core Recovery Tools
- **📊 Progress Tracking** - Visual day counter and milestone celebrations
- **🤖 AI Coach** - 24/7 AI-powered support and guidance via WebSocket chat
- **🚨 Panic Button** - Instant access to emergency coping strategies
- **📝 Daily Check-ins** - Track habits, mood, and triggers
- **📈 Recovery Analytics** - Comprehensive scoreboard with symptom tracking

### 🧘 Wellness & Support
- **🧘‍♂️ Meditation Center** - Guided mindfulness exercises
- **📖 Journal** - Private reflection and thought tracking
- **😊 Mood & Sleep Tracking** - Monitor overall mental health
- **🎯 Distraction Tools** - Healthy activities to redirect urges
- **💪 Motivational Content** - Articles, videos, and daily quotes

### 👥 Community & Social
- **👥 Community Forum** - Anonymous peer support and discussion
- **💬 Comment System** - Share experiences and encourage others
- **🏅 Achievement System** - Celebrate recovery milestones

### 🔐 Privacy & Security
- **🔒 Privacy Lock** - Biometric authentication (Face ID/Touch ID)
- **🔐 Local Authentication** - Secure app access
- **📱 Offline Support** - Core features work without internet

### 💳 Premium Features
- **💰 Stripe Payment Integration** - Secure subscription management
- **🎁 Premium Content** - Advanced tools and resources
- **📊 Detailed Analytics** - In-depth recovery insights

---

## 🏗️ Project Structure

```
lib/
├── app.dart                          # Main app configuration
├── main.dart                         # Entry point
├── core/                             # Core functionality
│   ├── bindings/                     # GetX dependency injection
│   ├── common/                       # Shared widgets & styles
│   ├── localization/                 # Multi-language support
│   ├── models/                       # Data models
│   ├── services/                     # API & storage services
│   ├── utils/                        # Utilities & constants
│   └── websoketMathod/              # WebSocket for AI Chat
├── features/                         # Feature modules
│   ├── ai_coach/                     # AI-powered chat support
│   ├── auth/                         # Authentication
│   ├── bottom_nav_ber/               # Navigation
│   ├── checkin/                      # Daily check-in system
│   ├── community/                    # Forum & discussions
│   ├── distractiontools_screen/      # Distraction activities
│   ├── home/                         # Main dashboard
│   ├── journal_screen/               # Personal journal
│   ├── meditation/                   # Meditation exercises
│   ├── motivational_content/         # Articles, videos, quotes
│   ├── onboring_screen/              # Onboarding flow
│   ├── panic/                        # Panic button & coping tools
│   ├── payment/                      # Stripe payment
│   ├── privacy_first/                # Biometric lock
│   ├── question_page/                # Initial assessment
│   ├── recovery/                     # Recovery tracking
│   ├── scoreboard_and_symtoms/       # Progress analytics
│   ├── sleep_tracking_mood_check/    # Wellness tracking
│   ├── splasho_screen/               # Splash screen
│   └── support/                      # Help & support
├── routes/                           # App navigation routes
└── services/                         # Global services
```

---

## 🛠️ Tech Stack

### Framework & Language
- **Flutter SDK** `^3.7.2` - Cross-platform development
- **Dart** `^3.7.2` - Programming language

### State Management & Architecture
- **GetX** `^4.6.6` - State management, navigation, and dependency injection

### UI/UX
- **flutter_screenutil** `^5.9.3` - Responsive UI
- **google_fonts** `^6.2.1` - Custom fonts
- **iconsax** `^0.0.8` - Icon library
- **lottie** `^3.3.1` - Animations
- **shimmer** `^3.0.0` - Loading effects

### Data & Networking
- **http** `^1.1.0` - REST API calls
- **web_socket_channel** `^3.0.1` - Real-time AI chat
- **json_annotation** `^4.9.0` - JSON serialization
- **json_serializable** `^6.9.0` - Code generation

### Storage & Persistence
- **shared_preferences** `^2.3.2` - Local data storage

### Media & Content
- **cached_network_image** `^3.3.0` - Image caching
- **video_player** `^2.8.1` - Video playback
- **url_launcher** `^6.1.12` - External links

### Security & Authentication
- **local_auth** `^2.1.0` - Biometric authentication
- **email_validator** `^3.0.0` - Email validation

### Payment
- **flutter_stripe** `^11.5.0` - Payment processing

### Data Visualization
- **fl_chart** `^0.71.0` - Charts and graphs
- **percent_indicator** `^4.2.5` - Progress indicators
- **pin_code_fields** `^8.0.1` - PIN input

### Utilities
- **intl** `^0.18.1` - Internationalization
- **logger** `^2.0.1` - Logging
- **flutter_easyloading** `^3.0.5` - Loading overlays

### Development Tools
- **build_runner** `^2.4.13` - Code generation
- **flutter_lints** `^5.0.0` - Dart linting
- **change_app_package_name** `^1.5.0` - Package management

---

## 📦 Installation & Setup

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK (3.7.2 or higher)
- Android Studio / Xcode
- Git

### Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd lustless_hichim890-main
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure API Keys**
   - Create `lib/services/api_keys.dart` with your API credentials
   - Add Stripe keys for payment integration
   - Configure WebSocket endpoint for AI chat

5. **Run the app**
   ```bash
   # For development
   flutter run

   # For specific platform
   flutter run -d android
   flutter run -d ios
   ```

---

## 🔧 Configuration

### 1. Stripe Payment Setup
Add your Stripe keys in `lib/services/api_keys.dart`:
```dart
class ApiKeys {
  static const String stripePublishableKey = 'your_publishable_key';
  static const String stripeSecretKey = 'your_secret_key';
}
```

### 2. WebSocket Configuration
Configure the WebSocket endpoint for AI Coach in the respective service file.

### 3. Biometric Authentication
Ensure proper permissions are set:

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSFaceIDUsageDescription</key>
<string>We need Face ID to secure your privacy</string>
```

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
```

---

## 🎨 Design System

### Color Palette
- **Primary Background**: Dark gradient theme
- **Accent Colors**: Blue tones (#133663, #071123)
- **Text Colors**: White (#FFFFFF), Light gray (#CECECE)

### Typography
- **Primary Font**: Google Fonts integration
- **Font Weights**: 400 (Regular), 500 (Medium), 600 (Semi-Bold), 700 (Bold)

### Responsive Design
- Uses `flutter_screenutil` for adaptive layouts
- Design size: 360x690 (reference screen)

---

## 📱 Supported Platforms

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- 🚧 **Web** (Partial support)
- 🚧 **macOS** (Configured, not tested)
- 🚧 **Linux** (Configured, not tested)
- 🚧 **Windows** (Configured, not tested)

---

## 🚀 Build & Release

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS (requires Mac)
```bash
flutter build ios --release
```

---

## 🧪 Testing

Run tests with:
```bash
flutter test
```

Widget tests are located in `test/widget_test.dart`.

---

## 📊 Key Workflows

### 1. User Onboarding
1. Splash Screen → Onboarding screens
2. Initial assessment questionnaire
3. Recovery plan generation
4. Goal setting & target date

### 2. Daily Usage
1. Biometric login (if enabled)
2. Daily check-in prompt
3. View progress dashboard
4. Access tools: AI Coach, Meditation, Journal
5. Engage with community

### 3. Recovery Tracking
- Automatic day counter
- Milestone notifications
- Symptom tracking
- Relapse handling with reset option

---

## 🔐 Privacy & Data

- **Local Storage**: User data stored securely on device
- **Biometric Protection**: Optional Face ID/Touch ID
- **Anonymous Community**: No personal info required for forum
- **Payment Security**: PCI-compliant Stripe integration

---

## 🤝 Contributing

This is a private project. For contribution inquiries, please contact the project owner.

---

## 📄 License

This project is private and proprietary. All rights reserved.

---

## 📞 Support

For support, feature requests, or bug reports:
- Use the in-app Support screen
- Contact: [Add your contact email]

---

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **GetX Community** - For state management solution
- **Stripe** - For secure payment processing
- **Recovery Community** - For inspiration and insights

---

## 📈 Roadmap

### Planned Features
- [ ] Advanced AI conversation improvements
- [ ] Group challenge system
- [ ] Detailed analytics dashboard
- [ ] Accountability partner matching
- [ ] Multi-language support (Bengali, Hindi, etc.)
- [ ] Offline mode enhancements
- [ ] Apple Health / Google Fit integration
- [ ] Widget support for quick access

---

## 🏆 App Statistics

- **178 Dart Files**
- **15+ Feature Modules**
- **30+ Dependencies**
- **Cross-platform**: Android, iOS, Web ready

---

**Built with ❤️ using Flutter**

*Empowering Recovery, One Day at a Time*
