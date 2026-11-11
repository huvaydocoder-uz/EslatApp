# Eslat 🔔

Yaqinlaringizning tug'ilgan kunlari, to'y kunlari va muhim uchrashuvlarini
eslatuvchi mobil ilova (Flutter, Android + iOS).

- Loyiha hujjati: [`docs/PROJECT.md`](docs/PROJECT.md)
- Firestore tuzilishi: [`docs/FIRESTORE.md`](docs/FIRESTORE.md)
- **Firebase'ni ulash va APK o'rnatish:** [`docs/FIREBASE_SETUP.md`](docs/FIREBASE_SETUP.md)

Tillar: o'zbek, rus, ingliz (`lib/l10n/*.arb`). Kirish: Gmail (bepul, kod kiritilmaydi).

## Ishga tushirish

Talab: Flutter **3.47+** (Dart 3.13+).

```bash
cp .env.example .env              # yoki: dart run tool/env_from_google_services.dart google-services.json
flutter pub get                   # 3 til tarjimalari ham shu yerda yaratiladi
dart run build_runner build       # freezed / json / riverpod kodlari (model o'zgarsa)
flutter run
flutter build apk --release       # -> build/app/outputs/flutter-apk/app-release.apk
```

`.env` bo'sh bo'lsa ham ilova ochiladi — kirishda "Firebase'ga ulanmagan" deydi.

## Tekshiruvlar

```bash
flutter analyze
flutter test

# Firestore + Storage Security Rules testlari (Node 20+, Java 21+, firebase-tools)
npm --prefix firebase/rules-tests install
npm --prefix firebase/rules-tests test
```

## Xavfsizlik

`.env`, `google-services.json`, `GoogleService-Info.plist`, `lib/firebase_options.dart`,
kalit (keystore) fayllari `.gitignore` da — ularni hech qachon commit qilmang.
Server sirlari (Telegram bot tokeni, SMS shlyuz kaliti) faqat Cloud Functions
Secret Manager'da saqlanadi.
