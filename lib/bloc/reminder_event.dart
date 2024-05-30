// lib/bloc/reminder_event.dart
import 'package:equatable/equatable.dart';
import '../models/reminder.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

class LoadReminders extends ReminderEvent {}

class AddNewReminder extends ReminderEvent {
  final Reminder reminder;

  const AddNewReminder(this.reminder);
}

class EditExistingReminder extends ReminderEvent {
  final Reminder reminder;

  const EditExistingReminder(this.reminder);
}

class DeleteReminder extends ReminderEvent {
  final String id;

  const DeleteReminder(this.id);
}
