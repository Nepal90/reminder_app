// lib/repositories/reminder_repository.dart
import '../models/reminder.dart';

abstract class ReminderRepository {
  Future<void> addReminder(Reminder reminder);
  Future<void> editReminder(Reminder reminder);
  Future<void> deleteReminder(String id);
  Future<List<Reminder>> getReminders();
}
