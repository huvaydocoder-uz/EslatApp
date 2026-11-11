# Firebase'ni ulash (bir martalik, ~10 daqiqa)

Bu qadamlar **bepul** (Spark tarifi) — Gmail orqali kirish va Firestore uchun
to'lov kartasi kerak emas. Faqat brauzer va Gmail hisobingiz kerak.

## 1. Loyiha yaratish

1. <https://console.firebase.google.com> ni oching, Gmail bilan kiring.
2. **Create a project** (Loyiha yaratish) → nomi: `Eslat` → davom eting.
3. Google Analytics — hozircha o'chirib qo'yishingiz mumkin → **Create project**.

## 2. Android ilovani qo'shish

1. Loyiha bosh sahifasida **Android** ikonkasini bosing.
2. Maydonlarni aynan shunday to'ldiring:

   | Maydon | Qiymat |
   |--------|--------|
   | Android package name | `uz.eslat` |
   | App nickname | `Eslat` |
   | Debug signing certificate SHA-1 | `3B:DF:34:9F:3D:2F:DC:17:C9:9C:35:92:A2:C6:B1:9B:0A:1A:6F:3A` |

3. **Register app** → keyingi qadamlarni (fayl yuklash, SDK qo'shish) **o'tkazib yuboring**
   (Next → Next → Continue to console). Faylni 5-qadamda yuklaymiz.

> SHA-1 — ilovaning "barmoq izi". Usiz Google "bu ilova Eslat emas" deb kirishni rad etadi.
> Bu qiymat repodagi sinov kaliti `android/app/eslat-test.keystore` ga tegishli.

## 3. Gmail orqali kirishni yoqish

1. Chap menyu: **Build → Authentication → Get started**.
2. **Sign-in method** → **Google** → **Enable**.
3. *Project support email* — Gmail manzilingizni tanlang → **Save**.

## 4. Ma'lumotlar bazasi (Firestore) va xavfsizlik qoidalari

1. **Build → Firestore Database → Create database**.
2. Location: **`europe-west3` (Frankfurt)** — O'zbekistonga eng yaqinlaridan.
   (Keyin o'zgartirib bo'lmaydi.)
3. **Start in production mode** → **Create**.
4. **Rules** yorlig'i → u yerdagi hamma matnni o'chiring → repodagi
   [`firebase/firestore.rules`](../firebase/firestore.rules) faylining **butun** matnini
   joylashtiring → **Publish**.

> "Test mode" ni TANLAMANG — u 30 kun davomida bazani hammaga ochiq qoldiradi.

## 5. Sozlama faylini yuklab olish

1. Chap yuqoridagi ⚙️ → **Project settings** → **General** → pastda **Your apps** →
   `Eslat (uz.eslat)`.
2. **google-services.json** ni yuklab oling (3-qadamdan **keyin** — aks holda faylda
   Gmail kirish uchun kerakli "web client" bo'lmaydi).

## 6. Ilovaga ulash

**A) Claude orqali:** `google-services.json` faylining ichidagi matnni chatga yuboring —
APK shu sozlama bilan yig'iladi. Bu fayl parol emas (har bir Android ilova ichida
bor), haqiqiy himoya — 4-qadamdagi qoidalar va 2-qadamdagi SHA-1. Fayl repoga
qo'shilmaydi.

**B) O'zingiz (kompyuterda Flutter bo'lsa):**

```bash
dart run tool/env_from_google_services.dart ~/Downloads/google-services.json
flutter build apk --release
# Tayyor: build/app/outputs/flutter-apk/app-release.apk
```

## Telefonga o'rnatish

1. APK faylni telefonga yuboring (Telegram "Saqlangan xabarlar", Google Drive yoki kabel).
2. Faylni oching → "Noma'lum manbalardan o'rnatish"ga ruxsat bering → **O'rnatish**.
3. **Eslat** ikonkasini oching → **Gmail orqali kirish** → hisobingizni tanlang. Tamom —
   keyingi safar ilova sizni o'zi taniydi.

## Keyinroq: Play Market

Do'konga chiqarishda alohida **maxfiy** kalit yaratiladi (`android/key.properties`,
git'ga tushmaydi) va uning SHA-1 si ham Firebase'ga qo'shiladi. Sinov kaliti
do'kon uchun ishlatilmaydi.
