import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../../core/utils/live_value.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/custom_category.dart';

part 'categories_repository.g.dart';

/// `users/{uid}/categories` — foydalanuvchining o'z turlari.
abstract interface class CategoriesRepository {
  Stream<List<CustomCategory>> watchAll(String uid);
  Future<String> create(String uid, CustomCategory category);
  Future<void> delete(String uid, String categoryId);
}

class FirestoreCategoriesRepository implements CategoriesRepository {
  const FirestoreCategoriesRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _ref(String uid) =>
      _db.collection(FirestorePaths.userCategories(uid));

  @override
  Stream<List<CustomCategory>> watchAll(String uid) =>
      _ref(uid).snapshots().map(
        (snap) => [
          for (final doc in snap.docs)
            CustomCategory.fromJson(doc.data()).copyWith(id: doc.id),
        ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())),
      );

  @override
  Future<String> create(String uid, CustomCategory category) async {
    final doc = _ref(uid).doc();
    await doc
        .set({
          ...category.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        })
        .timeout(const Duration(seconds: 4), onTimeout: () {});
    return doc.id;
  }

  @override
  Future<void> delete(String uid, String categoryId) =>
      _ref(uid)
          .doc(categoryId)
          .delete()
          .timeout(const Duration(seconds: 4), onTimeout: () {});
}

class InMemoryCategoriesRepository implements CategoriesRepository {
  final _byUser = <String, List<CustomCategory>>{};
  final _changes = StreamController<String>.broadcast();
  var _nextId = 1;

  @override
  Stream<List<CustomCategory>> watchAll(String uid) => liveValue(
    () => List.unmodifiable(_byUser[uid] ?? const <CustomCategory>[]),
    _changes.stream.where((id) => id == uid),
  );

  @override
  Future<String> create(String uid, CustomCategory category) async {
    final id = 'type-${_nextId++}';
    (_byUser[uid] ??= []).add(category.copyWith(id: id));
    _changes.add(uid);
    return id;
  }

  @override
  Future<void> delete(String uid, String categoryId) async {
    _byUser[uid]?.removeWhere((c) => c.id == categoryId);
    _changes.add(uid);
  }
}

@Riverpod(keepAlive: true)
CategoriesRepository categoriesRepository(Ref ref) {
  if (!ref.watch(firebaseReadyProvider)) return InMemoryCategoriesRepository();
  return FirestoreCategoriesRepository(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<List<CustomCategory>> customCategories(Ref ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(const []);
  return ref.watch(categoriesRepositoryProvider).watchAll(user.uid);
}
