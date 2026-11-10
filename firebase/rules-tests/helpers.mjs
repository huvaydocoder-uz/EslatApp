import { readFileSync } from 'node:fs';
import { initializeTestEnvironment } from '@firebase/rules-unit-testing';
import { doc, setDoc, serverTimestamp, Timestamp } from 'firebase/firestore';

export const PROJECT_ID = 'demo-eslat';

const rules = (file) =>
  readFileSync(new URL(`../${file}`, import.meta.url), 'utf8');

export function createEnv({ storage = false } = {}) {
  return initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: { rules: rules('firestore.rules') },
    ...(storage ? { storage: { rules: rules('storage.rules') } } : {}),
  });
}

/** Qoidalarni chetlab o'tib ma'lumot yozish (serverni taqlid qiladi). */
export async function seed(env, path, data) {
  await env.withSecurityRulesDisabled(async (ctx) => {
    await setDoc(doc(ctx.firestore(), path), data);
  });
}

export function userDoc(extra = {}) {
  return {
    displayName: 'Ali',
    locale: 'uz',
    timezone: 'Asia/Tashkent',
    plan: 'free',
    settings: { themeMode: 'dark', seedColor: 0xff3f51b5, notifyTime: '09:00' },
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
    ...extra,
  };
}

/** Serverda saqlangan holatdagi foydalanuvchi (seed uchun). */
export function storedUser(extra = {}) {
  return {
    ...userDoc(),
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
    ...extra,
  };
}

export function eventDoc(extra = {}) {
  return {
    title: "Onamning tug'ilgan kuni",
    personName: 'Onam',
    category: 'parentBirthday',
    emoji: '🎂',
    day: 14,
    month: 3,
    year: 1965,
    repeatYearly: true,
    remindDaysBefore: [0, 1],
    notifyTime: '09:00',
    alarmEnabled: true,
    smsMode: 'manual',
    phone: '+998901234567',
    smsText: "Tug'ilgan kuningiz muborak!",
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
    ...extra,
  };
}

export const inOneYear = () =>
  Timestamp.fromMillis(Date.now() + 365 * 24 * 3600 * 1000);
export const yesterday = () =>
  Timestamp.fromMillis(Date.now() - 24 * 3600 * 1000);
