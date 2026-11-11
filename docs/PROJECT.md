# Eslat — loyiha hujjati

## LOYIHA

**Eslat** — yaqinlarning tug'ilgan kunlari, turmush qurgan kunlari, ota-onaning
tavallud ayyomlari va muhim uchrashuvlarni unutmaslik uchun mobil ilova
(Android va iOS). Foydalanuvchi muhim kunni bir marta emoji bilan qo'shadi,
o'sha kun kelganda ilova push-xabar yuboradi, to'liq ekranda **to'xtatilmaguncha
chaladigan budilnik** bilan kim va nima uchun tabriklash kerakligini aytadi,
hamda tayyor matn bilan **SMS yuborishga** yordam beradi. Ilova O'zbekiston
va xalqaro bozor uchun **3 tilda** (o'zbek, rus, ingliz) ishlaydi, har qanday
yoshdagi odam uchun sodda: katta shriftlar, 4 ta aniq bo'lim, ortiqcha narsa yo'q.
Asosiy imkoniyatlar bepul; arxitekturada **Pro** tarif uchun joy tayyor
(avto-SMS, o'z musiqasi, ko'proq eslatma).

## EKRANLAR

Pastki menyudagi **4 ta asosiy bo'lim** (80dp balandlik, 28dp ikonka, yozuvlar doim ko'rinadi):

| # | Bo'lim | Ikonka | Vazifasi |
|---|--------|--------|----------|
| 1 | **Asosiy** | 🏠 `home` | Bugungi muhim kunlar (katta kartalar, "Tabriklash" tugmasi) va yaqin 30 kun |
| 2 | **Kunlar** | 🎉 `celebration` | Barcha muhim kunlar ro'yxati, toifa bo'yicha filtr, qidiruv |
| 3 | **Taqvim** | 📅 `calendar_month` | Oylik taqvim, kunlar emoji bilan belgilanadi |
| 4 | **Sozlamalar** | ⚙️ `settings` | Kunduzgi/tungi rejim, rang tanlash, ovoz, eslatma vaqti, hisob, Pro |

Bo'limlardan tashqari asosiy ekranlar:

| Ekran | Yo'l (route) | Vazifasi |
|-------|--------------|----------|
| Kirish | `/auth` | **Gmail orqali, bepul, kod kiritilmaydi**; keyingi safar avtomatik (telefon va Telegram — keyinroq) |
| Kun qo'shish / tahrirlash | `/event/new`, `/event/:id/edit` | Ism, sana, toifa, emoji, eslatma, SMS matni |
| Kun tafsilotlari | `/event/:id` | Batafsil + "SMS yuborish", "Qo'ng'iroq" |
| Budilnik | `/alarm/:id` | To'liq ekran, musiqa to'xtatilmaguncha chaladi |
| Pro | `/pro` | Tariflar (keyinroq) |

## BAZADA NIMA SAQLANADI (Firestore)

Batafsil maydonlar: [`docs/FIRESTORE.md`](FIRESTORE.md). Qoidalar: [`firebase/firestore.rules`](../firebase/firestore.rules).

| Kolleksiya | Kim yozadi | Nima |
|------------|-----------|------|
| `users/{uid}` | foydalanuvchi (tarifdan tashqari) | Profil, til, soat mintaqasi, sozlamalar (mavzu, rang, eslatma vaqti), `plan` |
| `users/{uid}/events/{id}` | foydalanuvchi | Muhim kun: sarlavha, kim, toifa, emoji, kun/oy/(yil), eslatmalar, budilnik, SMS |
| `users/{uid}/devices/{id}` | foydalanuvchi | FCM token, platforma (push yuborish uchun) |
| `users/{uid}/smsLogs/{id}` | **faqat server** | Yuborilgan avto-SMS tarixi (Pro) |
| `plans/{id}` | **faqat server** | Tariflar katalogi (o'qish — kirganlar uchun) |
| `telegramLoginSessions/{id}` | **faqat server** | Telegram orqali kirish sessiyalari (mijozga butunlay yopiq) |

Storage: `users/{uid}/avatar/*` (≤2 MB rasm), `users/{uid}/sounds/*` (≤10 MB audio, faqat Pro).

---

## Arxitektura (feature-first)

```
lib/
├── main.dart                     # .env → Firebase → ProviderScope
├── app.dart                      # MaterialApp.router (mavzu + router + o'zbek tili)
├── core/
│   ├── config/                   # env.dart (.env), firebase_options.dart
│   ├── constants/                # app_constants.dart (Firestore yo'llari va h.k.)
│   ├── l10n/                     # AppLanguage (uz/ru/en), context.l10n
│   ├── firebase/                 # Firebase providerlari (Auth, Firestore, Storage, FCM)
│   ├── router/                   # app_router.dart, app_routes.dart, auth_redirect.dart, main_shell.dart
│   └── theme/                    # app_theme.dart, app_palette.dart, theme_settings.dart, theme_controller.dart
├── l10n/                         # app_uz.arb (asosiy), app_ru.arb, app_en.arb + gen/
├── features/
│   ├── auth/{data,domain,presentation}   # Gmail kirish, AuthController
│   ├── profile/{data,domain}             # users/{uid}: UserProfile, ProfileRepository
│   ├── home/presentation
│   ├── events/{data,domain,presentation}
│   ├── calendar/presentation
│   ├── settings/{data,presentation}      # til, mavzu, rang, chiqish
│   ├── alarm/{data,presentation}        # 4-qadam
│   └── subscription/domain              # AppPlan + Entitlements (Pro uchun joy)
└── shared/widgets/               # AppButton, AppLogo, Loading/Error/EmptyView, AsyncValueView
firebase/                         # firestore.rules, storage.rules, indexes, rules-tests/
assets/branding/                  # eslat_logo.svg (qo'ng'iroqcha), 1024px PNG
```

Qoidalar qanday ta'minlangan:

- **Biznes mantiq faqat Riverpod'da** (`@riverpod` kod generatsiyasi). Widgetlar faqat ko'rsatadi.
- **3 holat**: har bir ma'lumotli ekran `AsyncValueView` orqali → `LoadingView` / `ErrorView` / `EmptyView`.
- **Matnlar** faqat `lib/l10n/app_*.arb` da (3 til, kalitlar bir xil). Yangi matn avval
  `app_uz.arb` ga, so'ng `app_ru.arb` va `app_en.arb` ga. **Modellar** — `freezed` + `json_serializable`.
- **Til**: foydalanuvchi tanlasa — profildagi til; aks holda telefon tili (uz/ru), boshqa
  tillarda — ingliz. **Mavzu va rang** ham profilda saqlanadi va barcha qurilmalarda bir xil.
- **Router** kirish holatini kuzatadi: kirmagan → `/auth`, kirgan → `/home`; bildirishnomadan
  ochilgan manzil (masalan `/alarm/abc`) splash'dan keyin yo'qolmaydi.
- **Material 3**: bitta seed rangdan kunduzgi + tungi sxema; foydalanuvchi 12 ta rangdan tanlaydi
  (keksalar uchun murakkab "color wheel" o'rniga katta doirachalar).

> **Muhim:** Flutter 3.44+ da Material kutubxonasi rasmiy alohida `material_ui` paketiga
> ko'chirilgan (`package:flutter/material.dart` o'rniga). go_router 18 ham shunga o'tgan,
> shuning uchun loyiha boshidanoq `material_ui` ishlatadi. Bu — Material 3'ning o'zi, yangi
> stack emas.

## Paketlar

**Stack (pubspec.yaml da faol):** `material_ui`, `go_router`, `flutter_riverpod`,
`riverpod_annotation`, `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`,
`firebase_messaging`, `freezed_annotation`, `json_annotation`, `flutter_dotenv`;
dev: `build_runner`, `freezed`, `json_serializable`, `riverpod_generator`, `flutter_lints`.

**Tasdiqlangan va qo'shilgan:** `google_sign_in` (Gmail orqali kirish), `intl` +
`flutter_localizations` (3 til — Flutter'ning standart tarjima tizimi).

**Tasdiqlashingiz kerak** (pubspec'da izohda turibdi, ruxsatsiz qo'shilmaydi):

| Paket | Nega kerak | Muqobil (paketsiz) |
|-------|-----------|--------------------|
| `flutter_local_notifications` + `timezone` + `flutter_timezone` | Eslatma internetsiz, aniq soatda, to'g'ri mintaqada | Faqat FCM — internet va serverga bog'liq, kechikadi |
| `alarm` | To'liq ekranli, **tinimsiz** chaladigan budilnik (Android'da ishonchli) | Yo'q — oddiy bildirishnoma ovozi ~30 soniya |
| `url_launcher` | Tayyor matnli SMS ilovasini va Telegram botni ochish | Yo'q |
| `cloud_functions` | Telegram orqali kirish, server eslatmalari, Pro avto-SMS | Yo'q — Telegram kirish serversiz xavfsiz bo'lmaydi |
| `firebase_app_check` | Soxta ilova/skriptlardan bazani himoya qilish | Faqat Security Rules |

Emoji va rang tanlash uchun paket **kerak emas** — o'zimiz tayyor katta emoji to'plami va
12 rangli palitra qilamiz (soddaroq va tushunarliroq).

## Muhim texnik qarorlar (halol cheklovlar)

1. **SMS.** iOS umuman, Google Play esa (SEND_SMS ruxsati) ilovaga SMS'ni *jimgina* yuborishga
   ruxsat bermaydi. Shuning uchun: **bepul** — SMS ilovasi tayyor matn va raqam bilan ochiladi,
   foydalanuvchi 1 marta "Yuborish"ni bosadi; **Pro** — SMS server orqali avtomatik ketadi
   (Cloud Functions + SMS shlyuz, masalan O'zbekiston uchun Eskiz.uz, xalqaro — Twilio).
2. **Tinimsiz budilnik.** Android'da to'liq ekranli, to'xtatilmaguncha chaladi. iOS'da ilova
   yopib tashlansa (swipe) uchinchi tomon ilovasi cheksiz chala olmaydi — bildirishnoma
   ovozi chaladi va foydalanuvchi ochganda budilnik ekrani davom etadi. iOS 26+ dagi
   AlarmKit bilan bu cheklovni keyinroq (native qism bilan) yopish mumkin.
3. **Telegram orqali kirish** (xavfsiz oqim): ilova → server bir martalik sessiya yaratadi →
   `t.me/<bot>?start=<sessiya>` ochiladi → bot 6 xonali kodni Telegram'da yuboradi →
   foydalanuvchi kodni ilovaga kiritadi → server tekshirib Firebase custom token beradi.
   Bot tokeni faqat serverda; kod xeshlanadi, 5 daqiqa amal qiladi, urinishlar cheklanadi.
4. **Kalitlar.** Firebase client sozlamalari `.env` da (git'da yo'q, namuna `.env.example`).
   Ular baribir ilova ichiga kiradi va maxfiy emas — haqiqiy himoya Security Rules + App
   Check. Bot tokeni va SMS kalitlari **faqat** Cloud Functions Secret Manager'da.
5. **Cloud Functions** Firebase'ning **Blaze** (to'lov kartasi ulangan) tarifini talab qiladi.

## Xavfsizlik (Security Rules) — qisqacha

- Standart holat — **taqiq**; har kim faqat `users/{o'z uid}` ichini ko'radi.
- Har bir yozuv tekshiriladi: ruxsat etilgan maydonlar ro'yxati, turi, uzunligi, formati
  (E.164 telefon, `HH:mm` vaqt, kun 1–31, oy 1–12, toifa ro'yxati).
- `plan`, `planExpiresAt`, `telegramId` — mijoz yoza olmaydi; Pro imkoniyatlari (avto-SMS,
  >2 eslatma, o'z musiqasi) qoidalar darajasida tarif bo'yicha tekshiriladi, muddati o'tgan
  Pro — bepul kabi.
- `createdAt`/`updatedAt` — faqat server vaqti; hisobni o'chirish — faqat server orqali.
- **29 ta avtomatik test** (Firebase Emulator): `firebase/rules-tests`.

## APK, PWA va iOS

- **Hozir — Android APK** (sinov uchun): `flutter build apk --release`. Firebase'ni ulash:
  [`docs/FIREBASE_SETUP.md`](FIREBASE_SETUP.md).
- **PWA tavsiya etilmaydi**: Flutter veb-versiya qila oladi, lekin brauzerda ilova yopiq
  bo'lganda budilnik chalmaydi, rejalashtirilgan eslatmalar ishlamaydi, iPhone'da push faqat
  "Bosh ekranga qo'shilgan" saytda ishlaydi. Eslat'ning asosiy vazifasi aynan shular.
- **iOS** — xuddi shu kod (qayta yozilmaydi). Kerak bo'ladi: Mac + Xcode (yoki bulutli
  macOS CI), Apple Developer hisobi (yiliga $99), `GoogleService-Info.plist` va Gmail kirish
  uchun URL sxemasi, push uchun APNs kaliti.

## Keyingi qadamlar (taklif)

| Qadam | Nima qilinadi |
|-------|---------------|
| **2** ✅ | Gmail orqali kirish (bepul, kodsiz), `users` profili, 3 til, Sozlamalar (til, mavzu, rang, chiqish), Android APK |
| **3** | Muhim kunlar: model, repository, qo'shish/tahrirlash (emoji to'plami), Asosiy, Kunlar, Taqvim |
| **4** | Eslatmalar: lokal bildirishnoma, budilnik ekrani, FCM, SMS ilovasini ochish |
| **5** | Server (Cloud Functions): Telegram bot orqali kirish, server eslatmalari, App Check |
| **6** | Pro (to'lov), rus/ingliz tillari, ilova ikonkasi, do'konlarga chiqarish |
