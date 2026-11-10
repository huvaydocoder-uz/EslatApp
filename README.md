# Eslat 🔔

Yaqinlaringizning tug'ilgan kunlari, to'y kunlari va muhim uchrashuvlarini
eslatuvchi mobil ilova (Flutter, Android + iOS).

- Loyiha hujjati: [`docs/PROJECT.md`](docs/PROJECT.md)
- Firestore tuzilishi: [`docs/FIRESTORE.md`](docs/FIRESTORE.md)

## Ishga tushirish

Talab: Flutter **3.47+** (Dart 3.13+).

```bash
cp .env.example .env              # Firebase sozlamalarini to'ldiring
flutter pub get
dart run build_runner build       # freezed / json / riverpod kodlari (model o'zgarsa)
flutter run
```

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
