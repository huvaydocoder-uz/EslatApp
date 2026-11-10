import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// Tizimga kirgan foydalanuvchi (Firebase `User` dan mustaqil domen modeli).
///
/// UI va router Firebase turlariga bog'lanmaydi — faqat shu modelni biladi.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
  }) = _AppUser;
}
