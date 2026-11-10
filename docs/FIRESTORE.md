# Firestore tuzilishi

Barcha maydon nomlari, turlari va cheklovlari [`firebase/firestore.rules`](../firebase/firestore.rules)
da **majburiy** tekshiriladi. Bu yerda o'zgarish bo'lsa — qoidalar va testlar ham o'zgaradi.

Belgilar: **M** — majburiy, ixtiyoriy maydon `null` yoki umuman yo'q bo'lishi mumkin.
`🔒 server` — mijoz (ilova) yoza olmaydi, faqat Cloud Functions (Admin SDK).

```
users/{uid}
 ├── events/{eventId}
 ├── devices/{deviceId}
 └── smsLogs/{logId}          🔒 server
plans/{planId}                🔒 server
telegramLoginSessions/{id}    🔒 server (mijozga butunlay yopiq)
```

## `users/{uid}` — profil va sozlamalar

| Maydon | Tur | M | Cheklov / izoh |
|--------|-----|---|----------------|
| `displayName` | string | | ≤ 60 |
| `email` | string | | ≤ 254 |
| `phoneNumber` | string | | E.164: `+998901234567` |
| `photoUrl` | string | | ≤ 1024 |
| `locale` | string | M | `uz` \| `ru` \| `en` |
| `timezone` | string | M | IANA, masalan `Asia/Tashkent` |
| `settings.themeMode` | string | | `system` \| `light` \| `dark` |
| `settings.seedColor` | int | | ARGB, palitradan (`0xFF3F51B5`) |
| `settings.notifyTime` | string | | `HH:mm`, standart eslatma vaqti |
| `settings.alarmSound` | string | | ≤ 64, ovoz nomi |
| `settings.defaultSmsText` | string | | ≤ 300, SMS shablon |
| `plan` | string | M | `free` \| `pro` — 🔒 yaratishda faqat `free`, keyin faqat server |
| `planExpiresAt` | timestamp | | 🔒 server |
| `telegramId` | int | | 🔒 server (Telegram orqali kirganda) |
| `createdAt` / `updatedAt` | timestamp | M | `FieldValue.serverTimestamp()` |

Mijoz profilni **o'chira olmaydi** — hisobni o'chirish server funksiyasi orqali (barcha ichki
kolleksiyalar va Storage fayllari bilan birga; App Store talabi).

## `users/{uid}/events/{eventId}` — muhim kun

| Maydon | Tur | M | Cheklov / izoh |
|--------|-----|---|----------------|
| `title` | string | M | 1–80, masalan "Onamning tug'ilgan kuni" |
| `personName` | string | | ≤ 60, "Onam" |
| `category` | string | M | `birthday` \| `anniversary` \| `parentBirthday` \| `meeting` \| `other` |
| `emoji` | string | M | 1–16 belgi (🎂 💍 👵 📅 …) |
| `day` | int | M | 1–31 |
| `month` | int | M | 1–12 |
| `year` | int | | 1900–2200; noma'lum bo'lsa yo'q (yoshni hisoblash uchun) |
| `time` | string | | `HH:mm` — uchrashuvlar uchun |
| `repeatYearly` | bool | M | Tug'ilgan kunlar — `true`, bir martalik uchrashuv — `false` |
| `remindDaysBefore` | list\<int\> | M | 1–5 ta, qiymatlar `{0,1,2,3,7,14,30}`; **bepul ≤ 2**, Pro ≤ 5 |
| `notifyTime` | string | | `HH:mm`, bo'lmasa profil sozlamasi |
| `alarmEnabled` | bool | M | O'sha kuni tinimsiz budilnik chalsinmi |
| `smsMode` | string | M | `off` \| `manual` (SMS ilovasini ochish) \| `auto` (**faqat Pro**) |
| `phone` | string | | E.164; `smsMode != off` bo'lsa **majburiy** |
| `smsText` | string | | ≤ 300 |
| `note` | string | | ≤ 500 |
| `nextReminderAt` | timestamp | | Keyingi eslatma vaqti (UTC) — server rejalashtiruvchisi uchun |
| `createdAt` / `updatedAt` | timestamp | M | server vaqti; `createdAt` o'zgarmaydi |

Nega sana `day`/`month`/`year` bo'lib saqlanadi: tug'ilgan kun har yili takrorlanadi va soat
mintaqasiga bog'liq emas; yil ko'pincha noma'lum. Ro'yxatni tartiblash va filtrlash ilovada
(foydalanuvchida odatda yuzlab emas, o'nlab yozuv bo'ladi).

**Indeks:** `nextReminderAt` — `COLLECTION_GROUP` (server har 15 daqiqada vaqti kelgan
eslatmalarni barcha foydalanuvchilar bo'yicha bitta so'rov bilan topadi) —
[`firestore.indexes.json`](../firebase/firestore.indexes.json).

## `users/{uid}/devices/{deviceId}` — push uchun qurilmalar

| Maydon | Tur | M | Cheklov |
|--------|-----|---|---------|
| `fcmToken` | string | M | 1–4096 |
| `platform` | string | M | `android` \| `ios` |
| `locale` | string | | `uz` \| `ru` \| `en` |
| `timezone` | string | | ≤ 64 |
| `appVersion` | string | | ≤ 32 |
| `updatedAt` | timestamp | M | server vaqti |

## `users/{uid}/smsLogs/{logId}` — 🔒 server

`eventId`, `to`, `status` (`sent`/`failed`), `provider`, `sentAt`. Foydalanuvchi faqat o'qiydi.
Server kunlik SMS limitini shu yerdan hisoblaydi (suiiste'molning oldini olish).

## `plans/{planId}` — 🔒 server

`name`, `priceUzs`, `priceUsd`, `period`, `features[]`. Kirgan foydalanuvchilar o'qiydi.

## `telegramLoginSessions/{sessionId}` — 🔒 server

`codeHash`, `telegramId`, `attempts`, `expiresAt` (5 daqiqa, TTL siyosati bilan avtomatik
o'chiriladi). Mijoz uchun o'qish ham, yozish ham **taqiqlangan**.
