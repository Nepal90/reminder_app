// lib/repositories/reminder_repository_impl.dart
import 'package:uuid/uuid.dart';
import '../models/reminder.dart';
import 'reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final List<Reminder> _reminders = [];
  final _uuid = Uuid();

  @override
  Future<void> addReminder(Reminder reminder) async {
    final newReminder = Reminder(
      id: _uuid.v4(),
      title: reminder.title,
      description: reminder.description,
      time: reminder.time,
      priority: reminder.priority,
    );
    _reminders.add(newReminder);
  }

  @override
  Future<void> editReminder(Reminder reminder) async {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
    }
  }

  @override
  Future<void> deleteReminder(id) async {
    _reminders.removeWhere((r) => r.id == id);
  }

  @override
  Future<List<Reminder>> getReminders() async {
    return _reminders;
  }
}
