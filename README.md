# Hızlı Flutter - 16 KB Ready 🚀

Flutter GetX mobil uygulama (Android/iOS). Google Play 16 KB page-size desteği ile güncellenmiş.

## ✅ Özellikler
- 16 KB Page-Size Desteği (NDK r25.2.9519653)
- Modern Build (AGP 8.2.1, Gradle 8.7, Java 21)
- Firebase Cloud Messaging
- GetX State Management

## 🔧 Kurulum

1. **Bağımlılıklar**
```bash
flutter pub get
```

2. **Hassas dosyaları yapılandır**
```bash
# API keys
cp lib/app_string.dart.example lib/app_string.dart
# Düzenle: lib/app_string.dart

# Firebase
# android/app/google-services.json ekle
# ios/Runner/GoogleService-Info.plist ekle

# Keystore (release)
cp android/key.properties.example android/key.properties
# Düzenle: android/key.properties
```

3. **Çalıştır**
```bash
flutter run
```

## 📱 Build

```bash
# APK
flutter build apk --release

# AAB (Play Store)
flutter build appbundle --release
```

## 🛠 Teknik
- Gradle: 8.7
- AGP: 8.2.1
- NDK: r25.2.9519653
- Target SDK: 35
- Min SDK: 21

## ⚠️ Önemli
`.gitignore` dosyası hassas bilgileri korur:
- `lib/app_string.dart` (API keys)
- `android/key.properties` (keystore)
- `google-services.json` (Firebase)

Template dosyaları kullanarak kendi bilgilerinizi ekleyin.
