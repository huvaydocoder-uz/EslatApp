/// Kirishdagi xatolik turlari. UI har biriga foydalanuvchi tilida tushunarli
/// xabar ko'rsatadi; texnik matn ekranga chiqmaydi.
enum AuthFailureReason { network, notConfigured, unknown }

class AuthFailure implements Exception {
  const AuthFailure(this.reason);

  final AuthFailureReason reason;

  @override
  String toString() => 'AuthFailure(${reason.name})';
}
