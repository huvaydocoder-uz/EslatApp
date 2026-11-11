import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../../core/utils/live_value.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/important_event.dart';

part 'events_repository.g.dart';

/// `users/{uid}/events` — muhim kunlar.
abstract interface class EventsRepository {
  Stream<List<ImportantEvent>> watchAll(String uid);

  /// Yangi kun; yaratilgan hujjat ID sini qaytaradi.
  Future<String> create(String uid, ImportantEvent event);

  Future<void> update(String uid, ImportantEvent event);

  Future<void> delete(String uid, String eventId);
}

/// Firestore. Internet bo'lmasa ham yozuv darhol telefonda ko'rinadi va
/// keyin serverga yuboriladi; shuning uchun server javobi 4 soniyagacha
/// kutiladi (ruxsat xatosi tez keladi), so'ng "navbatga qo'yildi" deb olinadi.
class FirestoreEventsRepository implements EventsRepository {
  const FirestoreEventsRepository(this._db);

  final FirebaseFirestore _db;
  static const _serverWait = Duration(seconds: 4);

  CollectionReference<Map<String, dynamic>> _events(String uid) =>
      _db.collection(FirestorePaths.userEvents(uid));

  @override
  Stream<List<ImportantEvent>> watchAll(String uid) =>
      _events(uid)
          .snapshots()
          .map((snap) => [for (final doc in snap.docs) ?_parse(doc)]);

  @override
  Future<String> create(String uid, ImportantEvent event) async {
    final ref = _events(uid).doc();
    await _commit(
      ref.set({
        ...event.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }),
    );
    return ref.id;
  }

  @override
  Future<void> update(String uid, ImportantEvent event) {
    final json = event.toJson();
    return _commit(
      _events(uid).doc(event.id).update({
        ...json,
        // Bo'shatilgan ixtiyoriy maydonlar serverdan ham o'chiriladi.
        for (final field in ImportantEvent.optionalFields)
          if (!json.containsKey(field)) field: FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      }),
    );
  }

  @override
  Future<void> delete(String uid, String eventId) =>
      _commit(_events(uid).doc(eventId).delete());

  static Future<void> _commit(Future<void> write) =>
      write.timeout(_serverWait, onTimeout: () {});

  /// Buzilgan hujjat butun ro'yxatni to'xtatmaydi — tashlab ketiladi.
  static ImportantEvent? _parse(DocumentSnapshot<Map<String, dynamic>> doc) {
    try {
      return ImportantEvent.fromJson(doc.data()!).copyWith(id: doc.id);
    } on Object catch (error) {
      if (kDebugMode) debugPrint('events/${doc.id} o\'qilmadi: $error');
      return null;
    }
  }
}

/// Sinov rejimi va testlar: ma'lumot faqat xotirada.
class InMemoryEventsRepository implements EventsRepository {
  final _byUser = <String, Map<String, ImportantEvent>>{};
  final _changes = StreamController<String>.broadcast();
  var _nextId = 1;

  List<ImportantEvent> _list(String uid) =>
      List.unmodifiable(_byUser[uid]?.values ?? const <ImportantEvent>[]);

  @override
  Stream<List<ImportantEvent>> watchAll(String uid) =>
      liveValue(() => _list(uid), _changes.stream.where((id) => id == uid));

  @override
  Future<String> create(String uid, ImportantEvent event) async {
    final id = 'local-${_nextId++}';
    (_byUser[uid] ??= {})[id] = event.copyWith(id: id);
    _changes.add(uid);
    return id;
  }

  @override
  Future<void> update(String uid, ImportantEvent event) async {
    (_byUser[uid] ??= {})[event.id] = event;
    _changes.add(uid);
  }

  @override
  Future<void> delete(String uid, String eventId) async {
    _byUser[uid]?.remove(eventId);
    _changes.add(uid);
  }
}

@Riverpod(keepAlive: true)
EventsRepository eventsRepository(Ref ref) {
  if (!ref.watch(firebaseReadyProvider)) return InMemoryEventsRepository();
  return FirestoreEventsRepository(ref.watch(firestoreProvider));
}

/// Kirgan foydalanuvchining barcha muhim kunlari (real vaqtda).
@Riverpod(keepAlive: true)
Stream<List<ImportantEvent>> events(Ref ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(const []);
  return ref.watch(eventsRepositoryProvider).watchAll(user.uid);
}
