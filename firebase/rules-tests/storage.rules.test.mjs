import { after, before, beforeEach, describe, test } from 'node:test';
import { assertFails, assertSucceeds } from '@firebase/rules-unit-testing';
import { createEnv, inOneYear, seed, storedUser } from './helpers.mjs';

let env;
const storage = (uid) =>
  uid ? env.authenticatedContext(uid).storage() : env.unauthenticatedContext().storage();
const bytes = (size) => new Uint8Array(size);
const upload = (uid, path, size, contentType) =>
  storage(uid).ref(path).put(bytes(size), { contentType });

before(async () => {
  env = await createEnv({ storage: true });
});
after(() => env.cleanup());
beforeEach(async () => {
  await env.clearFirestore();
  await env.clearStorage();
  await seed(env, 'users/alice', storedUser());
});

describe('avatar', () => {
  test("egasi kichik rasm yuklaydi va o'qiydi", async () => {
    await assertSucceeds(upload('alice', 'users/alice/avatar/avatar.jpg', 1024, 'image/jpeg'));
    await assertSucceeds(storage('alice').ref('users/alice/avatar/avatar.jpg').getMetadata());
  });

  test('begona, katta, rasm emas yoki noto\'g\'ri nom — rad', async () => {
    await assertFails(upload('bob', 'users/alice/avatar/avatar.jpg', 1024, 'image/jpeg'));
    await assertFails(upload(null, 'users/alice/avatar/avatar.jpg', 1024, 'image/jpeg'));
    await assertFails(upload('alice', 'users/alice/avatar/avatar.jpg', 3 * 1024 * 1024, 'image/jpeg'));
    await assertFails(upload('alice', 'users/alice/avatar/avatar.jpg', 1024, 'application/pdf'));
    await assertFails(upload('alice', 'users/alice/avatar/virus.exe', 1024, 'image/jpeg'));
  });

  test("boshqa foydalanuvchi o'qiy olmaydi", async () => {
    await assertSucceeds(upload('alice', 'users/alice/avatar/avatar.png', 1024, 'image/png'));
    await assertFails(storage('bob').ref('users/alice/avatar/avatar.png').getMetadata());
  });
});

describe('budilnik musiqasi (Pro)', () => {
  test('bepul tarifda yuklab bo\'lmaydi', async () => {
    await assertFails(upload('alice', 'users/alice/sounds/my_song.mp3', 1024, 'audio/mpeg'));
  });

  test('Pro tarifda yuklanadi', async () => {
    await seed(env, 'users/alice', storedUser({ plan: 'pro', planExpiresAt: inOneYear() }));
    await assertSucceeds(upload('alice', 'users/alice/sounds/my_song.mp3', 1024, 'audio/mpeg'));
  });

  test('Pro bo\'lsa ham: katta fayl va audio emas — rad', async () => {
    await seed(env, 'users/alice', storedUser({ plan: 'pro' }));
    await assertFails(upload('alice', 'users/alice/sounds/big.mp3', 11 * 1024 * 1024, 'audio/mpeg'));
    await assertFails(upload('alice', 'users/alice/sounds/song.mp3', 1024, 'text/html'));
  });

  test('ruxsat etilmagan yo\'l yopiq', async () => {
    await assertFails(upload('alice', 'public/anything.mp3', 1024, 'audio/mpeg'));
  });
});
