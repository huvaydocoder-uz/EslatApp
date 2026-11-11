import { after, before, beforeEach, describe, test } from 'node:test';
import { assertFails, assertSucceeds } from '@firebase/rules-unit-testing';
import {
  collection,
  deleteDoc,
  deleteField,
  doc,
  getDoc,
  getDocs,
  serverTimestamp,
  setDoc,
  Timestamp,
  updateDoc,
} from 'firebase/firestore';
import {
  createEnv,
  eventDoc,
  inOneYear,
  seed,
  storedUser,
  userDoc,
  yesterday,
} from './helpers.mjs';

let env;
const db = (uid) =>
  uid ? env.authenticatedContext(uid).firestore() : env.unauthenticatedContext().firestore();

before(async () => {
  env = await createEnv();
});
after(() => env.cleanup());
beforeEach(() => env.clearFirestore());

describe('users/{uid}', () => {
  test("o'z profilini 'free' tarif bilan yaratadi", async () => {
    await assertSucceeds(setDoc(doc(db('alice'), 'users/alice'), userDoc()));
  });

  test("o'ziga 'pro' tarif yoki telegramId yoza olmaydi", async () => {
    await assertFails(setDoc(doc(db('alice'), 'users/alice'), userDoc({ plan: 'pro' })));
    await assertFails(setDoc(doc(db('alice'), 'users/alice'), userDoc({ telegramId: 123 })));
    await assertFails(
      setDoc(doc(db('alice'), 'users/alice'), userDoc({ planExpiresAt: inOneYear() })),
    );
  });

  test('boshqa odam nomidan profil yarata olmaydi', async () => {
    await assertFails(setDoc(doc(db('bob'), 'users/alice'), userDoc()));
    await assertFails(setDoc(doc(db(null), 'users/alice'), userDoc()));
  });

  test("createdAt'ni mijoz o'zi belgilay olmaydi", async () => {
    const old = Timestamp.fromDate(new Date('2020-01-01'));
    await assertFails(setDoc(doc(db('alice'), 'users/alice'), userDoc({ createdAt: old })));
  });

  test("noto'g'ri maydonlar rad etiladi", async () => {
    const bad = [
      { isAdmin: true },
      { locale: 'de' },
      { timezone: '' },
      { phoneNumber: '901234567' },
      { displayName: 'x'.repeat(61) },
      { settings: { notifyTime: '25:00' } },
      { settings: { themeMode: 'neon' } },
      { settings: { seedColor: 'red' } },
      { settings: { hacker: true } },
    ];
    for (const extra of bad) {
      await assertFails(setDoc(doc(db('alice'), 'users/alice'), userDoc(extra)));
    }
  });

  test('faqat egasi o\'qiydi', async () => {
    await seed(env, 'users/alice', storedUser());
    await assertSucceeds(getDoc(doc(db('alice'), 'users/alice')));
    await assertFails(getDoc(doc(db('bob'), 'users/alice')));
    await assertFails(getDoc(doc(db(null), 'users/alice')));
  });

  test("sozlamalarni yangilaydi, lekin tarifni o'zgartira olmaydi", async () => {
    await seed(env, 'users/alice', storedUser());
    const ref = doc(db('alice'), 'users/alice');
    await assertSucceeds(
      updateDoc(ref, { 'settings.themeMode': 'light', updatedAt: serverTimestamp() }),
    );
    await assertFails(updateDoc(ref, { plan: 'pro', updatedAt: serverTimestamp() }));
    await assertFails(
      updateDoc(ref, { planExpiresAt: inOneYear(), updatedAt: serverTimestamp() }),
    );
    await assertFails(updateDoc(ref, { telegramId: 1, updatedAt: serverTimestamp() }));
    await assertFails(updateDoc(ref, { 'settings.themeMode': 'light' }));
  });

  test("ilova yozadigan sozlamalar: til va rang (Sozlamalar ekrani)", async () => {
    await seed(env, 'users/alice', storedUser());
    const ref = doc(db('alice'), 'users/alice');
    for (const locale of ['uz', 'ru', 'en']) {
      await assertSucceeds(updateDoc(ref, { locale, updatedAt: serverTimestamp() }));
    }
    await assertSucceeds(
      updateDoc(ref, { 'settings.seedColor': 0xff00897b, updatedAt: serverTimestamp() }),
    );
    await assertFails(updateDoc(ref, { locale: 'de', updatedAt: serverTimestamp() }));
    await assertFails(
      updateDoc(ref, { 'settings.seedColor': '#00897b', updatedAt: serverTimestamp() }),
    );
  });

  test('ilova yaratadigan profil (rasm/ism yo\'q holat ham) qabul qilinadi', async () => {
    // lib/features/profile: include_if_null=false — null maydonlar yozilmaydi.
    const appProfile = {
      email: 'ali@gmail.com',
      locale: 'ru',
      timezone: 'Asia/Tashkent',
      plan: 'free',
      settings: { themeMode: 'system', seedColor: 0xff3f51b5 },
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    };
    await assertSucceeds(setDoc(doc(db('alice'), 'users/alice'), appProfile));
  });

  test("profilni mijoz o'chira olmaydi (faqat server)", async () => {
    await seed(env, 'users/alice', storedUser());
    await assertFails(deleteDoc(doc(db('alice'), 'users/alice')));
  });
});

describe('users/{uid}/events', () => {
  const eventRef = (uid, owner = 'alice', id = 'e1') =>
    doc(db(uid), `users/${owner}/events/${id}`);

  beforeEach(() => seed(env, 'users/alice', storedUser()));

  test("o'z muhim kunini qo'shadi, o'qiydi, o'chiradi", async () => {
    await assertSucceeds(setDoc(eventRef('alice'), eventDoc()));
    await assertSucceeds(getDoc(eventRef('alice')));
    await assertSucceeds(getDocs(collection(db('alice'), 'users/alice/events')));
    await assertSucceeds(deleteDoc(eventRef('alice')));
  });

  test("boshqa foydalanuvchi o'qiy ham, yoza ham olmaydi", async () => {
    await seed(env, 'users/alice/events/e1', { ...eventDoc(), createdAt: Timestamp.now(), updatedAt: Timestamp.now() });
    await assertFails(getDoc(eventRef('bob')));
    await assertFails(getDocs(collection(db('bob'), 'users/alice/events')));
    await assertFails(setDoc(eventRef('bob', 'alice', 'e2'), eventDoc()));
    await assertFails(deleteDoc(eventRef('bob')));
    await assertFails(getDoc(eventRef(null)));
  });

  test('minimal (ixtiyoriy maydonlarsiz) kun qabul qilinadi', async () => {
    const minimal = eventDoc({ smsMode: 'off' });
    for (const key of ['personName', 'year', 'notifyTime', 'phone', 'smsText']) {
      delete minimal[key];
    }
    await assertSucceeds(setDoc(eventRef('alice'), minimal));
  });

  test("noto'g'ri ma'lumotlar rad etiladi", async () => {
    const bad = [
      { title: '' },
      { title: 'x'.repeat(81) },
      { category: 'party' },
      { emoji: '' },
      { day: 0 },
      { day: 32 },
      { month: 13 },
      { day: '14' },
      { year: 1800 },
      { time: '9:00' },
      { remindDaysBefore: [] },
      { remindDaysBefore: [5] },
      { smsMode: 'sometimes' },
      { phone: '901234567' },
      { phone: null },
      { smsText: 'x'.repeat(301) },
      { note: 'x'.repeat(501) },
      { nextReminderAt: 'ertaga' },
      { ownerId: 'bob' },
    ];
    for (const extra of bad) {
      await assertFails(setDoc(eventRef('alice'), eventDoc(extra)), JSON.stringify(extra));
    }
  });

  test('ilova yozadigan shakl va barcha "og\'ir" emojilar qabul qilinadi', async () => {
    // lib/features/events: include_if_null=false, smsMode='off', id yozilmaydi.
    const appEvent = {
      title: 'Onam',
      category: 'parentBirthday',
      emoji: '👵',
      day: 29,
      month: 2,
      repeatYearly: true,
      remindDaysBefore: [0, 1],
      alarmEnabled: true,
      smsMode: 'off',
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
    };
    await assertSucceeds(setDoc(eventRef('alice', 'alice', 'app1'), appEvent));
    const emojis = ['🗓️', '🍽️', '✈️', '❤️', '🤱', '🕌'];
    for (const [i, emoji] of emojis.entries()) {
      await assertSucceeds(
        setDoc(eventRef('alice', 'alice', `emoji${i}`), { ...appEvent, emoji }),
      );
    }
  });

  test("tahrirlashda bo'shatilgan maydon o'chiriladi (FieldValue.delete)", async () => {
    await seed(env, 'users/alice/events/e1', {
      ...eventDoc(),
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    });
    await assertSucceeds(
      updateDoc(eventRef('alice'), {
        personName: deleteField(),
        note: deleteField(),
        smsMode: 'off',
        phone: deleteField(),
        smsText: deleteField(),
        updatedAt: serverTimestamp(),
      }),
    );
  });

  test("bepul tarif: avto-SMS va 2 tadan ortiq eslatma yo'q", async () => {
    await assertFails(setDoc(eventRef('alice'), eventDoc({ smsMode: 'auto' })));
    await assertFails(setDoc(eventRef('alice'), eventDoc({ remindDaysBefore: [0, 1, 7] })));
  });

  test('Pro tarif: avto-SMS va 5 tagacha eslatma mumkin', async () => {
    await seed(env, 'users/alice', storedUser({ plan: 'pro', planExpiresAt: inOneYear() }));
    await assertSucceeds(
      setDoc(eventRef('alice'), eventDoc({ smsMode: 'auto', remindDaysBefore: [0, 1, 3, 7, 30] })),
    );
  });

  test("muddati o'tgan Pro — bepul tarif kabi", async () => {
    await seed(env, 'users/alice', storedUser({ plan: 'pro', planExpiresAt: yesterday() }));
    await assertFails(setDoc(eventRef('alice'), eventDoc({ smsMode: 'auto' })));
  });

  test("yangilashda createdAt o'zgarmaydi, updatedAt — server vaqti", async () => {
    await seed(env, 'users/alice/events/e1', { ...eventDoc(), createdAt: Timestamp.now(), updatedAt: Timestamp.now() });
    const ref = eventRef('alice');
    await assertSucceeds(updateDoc(ref, { title: 'Dadamning tug\'ilgan kuni', updatedAt: serverTimestamp() }));
    await assertFails(updateDoc(ref, { title: 'X' }));
    await assertFails(
      updateDoc(ref, { createdAt: Timestamp.fromDate(new Date('2020-01-01')), updatedAt: serverTimestamp() }),
    );
  });
});

describe('users/{uid}/devices', () => {
  const device = (extra = {}) => ({
    fcmToken: 'token-123',
    platform: 'android',
    locale: 'uz',
    timezone: 'Asia/Tashkent',
    appVersion: '0.1.0',
    updatedAt: serverTimestamp(),
    ...extra,
  });

  test("o'z qurilmasini ro'yxatdan o'tkazadi", async () => {
    await assertSucceeds(setDoc(doc(db('alice'), 'users/alice/devices/d1'), device()));
  });

  test("noto'g'ri qurilma yoki begona foydalanuvchi rad etiladi", async () => {
    await assertFails(setDoc(doc(db('alice'), 'users/alice/devices/d1'), device({ platform: 'web' })));
    await assertFails(setDoc(doc(db('alice'), 'users/alice/devices/d1'), device({ fcmToken: '' })));
    await assertFails(setDoc(doc(db('bob'), 'users/alice/devices/d1'), device()));
  });
});

describe('server kolleksiyalari', () => {
  test("smsLogs: egasi o'qiydi, hech kim yoza olmaydi", async () => {
    await seed(env, 'users/alice/smsLogs/l1', { status: 'sent' });
    await assertSucceeds(getDoc(doc(db('alice'), 'users/alice/smsLogs/l1')));
    await assertFails(getDoc(doc(db('bob'), 'users/alice/smsLogs/l1')));
    await assertFails(setDoc(doc(db('alice'), 'users/alice/smsLogs/l2'), { status: 'sent' }));
  });

  test("plans: kirganlar o'qiydi, hech kim yoza olmaydi", async () => {
    await seed(env, 'plans/pro', { name: 'Pro' });
    await assertSucceeds(getDoc(doc(db('alice'), 'plans/pro')));
    await assertFails(getDoc(doc(db(null), 'plans/pro')));
    await assertFails(setDoc(doc(db('alice'), 'plans/pro'), { name: 'Bepul Pro' }));
  });

  test('telegramLoginSessions: mijoz uchun butunlay yopiq', async () => {
    await seed(env, 'telegramLoginSessions/s1', { codeHash: 'x' });
    await assertFails(getDoc(doc(db('alice'), 'telegramLoginSessions/s1')));
    await assertFails(setDoc(doc(db('alice'), 'telegramLoginSessions/s2'), { codeHash: 'y' }));
  });

  test("noma'lum kolleksiya yopiq", async () => {
    await assertFails(setDoc(doc(db('alice'), 'secrets/x'), { a: 1 }));
    await assertFails(getDoc(doc(db('alice'), 'secrets/x')));
  });
});
