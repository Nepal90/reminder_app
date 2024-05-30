// lib/bloc/reminder_state.dart
import 'package:equatable/equatable.dart';
import '../models/reminder.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

class RemindersLoading extends ReminderState {}

class RemindersLoaded extends ReminderState {
  final List<Reminder> reminders;

  RemindersLoaded(this.reminders);
}

class RemindersError extends ReminderState {
  final String message;

  RemindersError(this.message);
}
