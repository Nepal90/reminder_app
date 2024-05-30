// lib/use_cases/edit_reminder.dart
import '../repositories/reminder_repository.dart';
import '../models/reminder.dart';

class EditReminder {
  final ReminderRepository repository;

  EditReminder(this.repository);

  Future<void> call(Reminder reminder) async {
    await repository.editReminder(reminder);
  }
}
