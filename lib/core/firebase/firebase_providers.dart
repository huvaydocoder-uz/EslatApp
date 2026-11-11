import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

/// Firebase xizmatlari providerlar orqali beriladi — testlarda oson
/// almashtiriladi (override) va kodda `X.instance` tarqalib ketmaydi.

/// Firebase ishga tushganmi. `.env` to'ldirilmagan bo'lsa `main` buni `false`
/// qiladi: ilova yiqilmaydi, kirish ekrani "ulanmagan" deb tushuntiradi.
@Riverpod(keepAlive: true)
bool firebaseReady(Ref ref) => true;

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(Ref ref) => FirebaseStorage.instance;

@Riverpod(keepAlive: true)
FirebaseMessaging firebaseMessaging(Ref ref) => FirebaseMessaging.instance;
