import 'package:eslat/app.dart';
import 'package:eslat/features/auth/data/auth_repository.dart';
import 'package:eslat/features/auth/domain/app_user.dart';
import 'package:eslat/features/profile/data/profile_repository.dart';
import 'package:eslat/features/profile/domain/user_profile.dart';
import 'package:eslat/l10n/gen/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

const testUser = AppUser(uid: 'u1', displayName: 'Ali', email: 'ali@gmail.com');

/// Testlar Firebase'siz ishlaydi: kirish holati va profil almashtiriladi.
Widget testApp({AppUser? user, UserProfile? profile}) => ProviderScope(
  overrides: [
    authStateProvider.overrideWith((ref) => Stream.value(user)),
    currentProfileProvider.overrideWith((ref) => Stream.value(profile)),
  ],
  child: const EslatApp(),
);

AppLocalizations l10nFor(String code) => lookupAppLocalizations(Locale(code));
