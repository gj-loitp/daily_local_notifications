import 'package:daily_local_notifications/daily_local_notifications.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('MyApp'),
        ),
        body: ElevatedButton(
          onPressed: () {
            debugPrint("roy93~ onPressed");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen2()),
            );
          },
          child: const Text('Go to Page 2'),
        ),
      ),
    );
  }
}

class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key});

  @override
  State<MainScreen2> createState() => _MainScreenState2();
}

class _MainScreenState2 extends State<MainScreen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page 2',
      home: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('Page 2'),
        ),
        body: DailyLocalNotifications(
          notificationConfig: const NotificationConfig(),
          config: const DailyLocalNotificationsConfig(),
          stylingConfig: StylingConfig(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).primaryColor.withOpacity(0.3),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          reminderTitleText: Text(
            'Reminder Title',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          reminderRepeatText: Text(
            'Repeat',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          reminderDailyText: Text(
            'Daily',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          timeNormalTextStyle: const TextStyle(fontSize: 24, color: Colors.grey),
          timeSelectedTextStyle: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
          onNotificationsUpdated: () {
            debugPrint("roy93~ Notifications updated");
          },
        ),
      ),
    );
  }
}
