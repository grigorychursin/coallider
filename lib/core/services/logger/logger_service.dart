import 'package:sentry_flutter/sentry_flutter.dart';

class LoggerService {
  const LoggerService._();

  static Future<void> logInfo(
    String message, {
    Map<String, String>? extra,
  }) async {
    await Sentry.captureMessage(
      message,
      level: SentryLevel.info,
      hint: Hint()..set('data', extra),
      params: [extra],
    );
  }
}
