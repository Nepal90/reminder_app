// lib/main.dart
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/bloc/reminder_event.dart';
import 'bloc/reminder_bloc.dart';
import 'repositories/reminder_repository_impl.dart';
import 'use_cases/add_reminder.dart';
import 'use_cases/edit_reminder.dart';
import 'use_cases/delete_reminder.dart';
import 'use_cases/get_reminders.dart';
import 'services/notification_service.dart';
import 'ui/reminder_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final reminderRepository = ReminderRepositoryImpl();
  final notificationService = NotificationService();
  await notificationService.init();

  runApp(MyApp(
    reminderRepository: reminderRepository,
    notificationService: notificationService,
  ));
}

class MyApp extends StatelessWidget {
  final ReminderRepositoryImpl reminderRepository;
  final NotificationService notificationService;

  MyApp({
    required this.reminderRepository,
    required this.notificationService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ReminderBloc(
          getReminders: GetReminders(reminderRepository),
          addReminder: AddReminder(reminderRepository),
          editReminder: EditReminder(reminderRepository),
          deleteReminder: DeleteReminder(reminderRepository),
          notificationService: notificationService,
        )..add(LoadReminders()),
        child: ReminderList(),
      ),
    );
  }
}
