// lib/ui/reminder_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reminder_bloc.dart';
import '../bloc/reminder_event.dart';
import '../bloc/reminder_state.dart';
import '../models/reminder.dart';
import 'add_edit_reminder.dart';

class ReminderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          if (state is RemindersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RemindersLoaded) {
            return ListView.builder(
              itemCount: state.reminders.length,
              itemBuilder: (context, index) {
                final reminder = state.reminders[index];
                return ListTile(
                  title: Text(reminder.title),
                  subtitle: Text(reminder.description),
                  trailing: Text(reminder.priority),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditReminderScreen(
                          reminder: reminder,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is RemindersError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditReminderScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
