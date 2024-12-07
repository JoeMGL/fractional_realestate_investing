import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  static Future<void> logScreenView(String screenName) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': screenName,
      },
    );
  }
}
