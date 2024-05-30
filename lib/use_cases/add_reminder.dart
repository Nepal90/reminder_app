// lib/use_cases/add_reminder.dart
import '../repositories/reminder_repository.dart';
import '../models/reminder.dart';

class AddReminder {
  final ReminderRepository repository;

  AddReminder(this.repository);

  Future<void> call(Reminder reminder) async {
    await repository.addReminder(reminder);
  }
}
