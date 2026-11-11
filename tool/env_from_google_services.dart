// google-services.json -> .env (Android Firebase sozlamalari).
//
// Ishlatish:  dart run tool/env_from_google_services.dart ~/Downloads/google-services.json
//
// .env dagi boshqa qiymatlar (iOS, Telegram) saqlanib qoladi. .env git'ga
// tushmaydi. Fayl ichidagi qiymatlar maxfiy parol emas (har bir ilovada bor),
// lekin baribir repoga qo'shilmaydi.
import 'dart:convert';
import 'dart:io';

const _packageName = 'uz.eslat';

void main(List<String> args) {
  if (args.length != 1) {
    stderr.writeln(
      'Ishlatish: dart run tool/env_from_google_services.dart <google-services.json>',
    );
    exit(64);
  }
  final json =
      jsonDecode(File(args.single).readAsStringSync()) as Map<String, dynamic>;
  final project = json['project_info'] as Map<String, dynamic>;
  final clients = (json['client'] as List).cast<Map<String, dynamic>>();
  String? packageOf(Map<String, dynamic> c) {
    final info = c['client_info'] as Map<String, dynamic>;
    final android = info['android_client_info'] as Map<String, dynamic>?;
    return android?['package_name'] as String?;
  }

  final client = clients.firstWhere(
    (c) => packageOf(c) == _packageName,
    orElse: () => throw StateError('"$_packageName" ilovasi faylda topilmadi.'),
  );
  final webClient = (client['oauth_client'] as List? ?? const [])
      .cast<Map<String, dynamic>>()
      .where((o) => o['client_type'] == 3)
      .map((o) => o['client_id'] as String)
      .firstOrNull;
  if (webClient == null) {
    stderr.writeln(
      'DIQQAT: Web client ID yo\'q. Firebase -> Authentication -> Google ni '
      'yoqib, google-services.json ni QAYTA yuklab oling.',
    );
  }

  final values = <String, String>{
    'FIREBASE_PROJECT_ID': project['project_id'] as String,
    'FIREBASE_MESSAGING_SENDER_ID': project['project_number'] as String,
    'FIREBASE_STORAGE_BUCKET': project['storage_bucket'] as String? ?? '',
    'FIREBASE_ANDROID_API_KEY':
        ((client['api_key'] as List).first as Map)['current_key'] as String,
    'FIREBASE_ANDROID_APP_ID':
        (client['client_info'] as Map)['mobilesdk_app_id'] as String,
    'GOOGLE_SERVER_CLIENT_ID': webClient ?? '',
  };

  final envFile = File('.env');
  final template = envFile.existsSync()
      ? envFile.readAsStringSync()
      : File('.env.example').readAsStringSync();
  final updated = template
      .split('\n')
      .map((line) {
        final key = line.split('=').first.trim();
        return values.containsKey(key) ? '$key=${values[key]}' : line;
      })
      .join('\n');
  envFile.writeAsStringSync(updated);
  stdout.writeln('.env yangilandi: ${values.keys.join(', ')}');
}
