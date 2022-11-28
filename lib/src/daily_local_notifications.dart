import 'package:daily_local_notifications/src/providers/reminder_settings_provider.dart';
import 'package:daily_local_notifications/src/repositories/reminder_repository.dart';
import 'package:daily_local_notifications/src/repositories/shared_prefs_repository.dart';
import 'package:daily_local_notifications/src/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays a row of toggle buttons for selecting days of the week.
/// Displays a daily-checkbox-button for selecting
/// or deselecting all days of the week.
class DailyLocalNotification extends StatefulWidget {
  /// Widget for displaying the "Reminder Title" text
  final Widget reminderTitleText;

  /// Widget for displaying the "Repeat" text on the left
  final Widget reminderRepeatText;

  /// Widget for displaying the "Daily" text for the toggle button on the right
  final Widget reminderDailyText;

  /// Active color for the day button
  /// Defaults to [Colors.blue]
  final Color dayActiveColor;

  /// Inactive color for the day button
  /// Defaults to [Colors.grey]
  final Color dayInactiveColor;

  final TextStyle timeNormalTextStyle;
  final TextStyle timeSelectedTextStyle;

  /// Constructor for [DailyLocalNotification]
  const DailyLocalNotification({
    super.key,
    required this.reminderTitleText,
    required this.reminderRepeatText,
    required this.reminderDailyText,
    required this.dayActiveColor,
    required this.dayInactiveColor,
    required this.timeNormalTextStyle,
    required this.timeSelectedTextStyle,
  });

  @override
  State<DailyLocalNotification> createState() => _DailyLocalNotificationState();
}

class _DailyLocalNotificationState extends State<DailyLocalNotification> {
  late Future<ReminderSettingsProvider> loadDependencies;

  @override
  void initState() {
    super.initState();
    loadDependencies = init();
  }

  /// Creates a [DailyLocalNotification] widget.
  Future<ReminderSettingsProvider> init() async {
    final reminderRepository = ReminderRepository(
      flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    );

    final sharedPrefs = await SharedPreferences.getInstance();
    final sharedPrefsRepository = SharedPrefsRepository(
      sharedPrefs: sharedPrefs,
    );

    final reminderSettingsProvider = ReminderSettingsProvider(
      reminderRepository: reminderRepository,
      sharedPrefsRepository: sharedPrefsRepository,
    );

    await reminderSettingsProvider.init();

    return reminderSettingsProvider;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReminderSettingsProvider>(
      future: loadDependencies,
      builder: (
        BuildContext context,
        AsyncSnapshot<ReminderSettingsProvider> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ChangeNotifierProvider<ReminderSettingsProvider>.value(
            value: snapshot.data!,
            child: DailyLocalNotificationWidget(
              reminderTitleText: widget.reminderTitleText,
              reminderRepeatText: widget.reminderRepeatText,
              reminderDailyText: widget.reminderDailyText,
              dayActiveColor: widget.dayActiveColor,
              dayInactiveColor: widget.dayInactiveColor,
              timeNormalTextStyle: widget.timeNormalTextStyle,
              timeSelectedTextStyle: widget.timeSelectedTextStyle,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
