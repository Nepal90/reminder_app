// lib/use_cases/get_reminders.dart
import '../repositories/reminder_repository.dart';
import '../models/reminder.dart';

class GetReminders {
  final ReminderRepository repository;

  GetReminders(this.repository);

  Future<List<Reminder>> call() async {
    return repository.getReminders();
  }
}
