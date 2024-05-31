// lib/bloc/reminder_bloc.dart
// ignore_for_file: unused_import

import 'package:bloc/bloc.dart';
import '../models/reminder.dart';
import '../use_cases/add_reminder.dart';
import '../use_cases/get_reminders.dart';
import '../use_cases/edit_reminder.dart';
import '../use_cases/delete_reminder.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';
import '../services/notification_service.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final GetReminders getReminders;
  final AddReminder addReminder;
  final EditReminder editReminder;
  final DeleteReminder deleteReminder;
  final NotificationService notificationService;

  ReminderBloc({
    required this.getReminders,
    required this.addReminder,
    required this.editReminder,
    required this.deleteReminder,
    required this.notificationService,
  }) : super(RemindersLoading()) {
    on<LoadReminders>((event, emit) async {
      try {
        final reminders = await getReminders();
        emit(RemindersLoaded(reminders));
      } catch (e) {
        emit(RemindersError(e.toString()));
      }
    });

    on<AddNewReminder>((event, emit) async {
      try {
        await addReminder(event.reminder);
        await notificationService.scheduleNotification(event.reminder);
        final reminders = await getReminders();
        emit(RemindersLoaded(reminders));
      } catch (e) {
        emit(RemindersError(e.toString()));
      }
    });

    on<EditExistingReminder>((event, emit) async {
      try {
        await editReminder(event.reminder);
        await notificationService.scheduleNotification(event.reminder);
        final reminders = await getReminders();
        emit(RemindersLoaded(reminders));
      } catch (e) {
        emit(RemindersError(e.toString()));
      }
    });

    on<DeleteExistingReminder>((event, emit) async {
      try {
        await deleteReminder(event.id);
        final reminders = await getReminders();
        emit(RemindersLoaded(reminders));
      } catch (e) {
        emit(RemindersError(e.toString()));
      }
    });
  }
}
