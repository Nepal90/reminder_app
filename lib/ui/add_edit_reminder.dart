// lib/ui/add_edit_reminder.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reminder_bloc.dart';
import '../bloc/reminder_event.dart';
import '../models/reminder.dart';

class AddEditReminderScreen extends StatefulWidget {
  final Reminder? reminder;

  AddEditReminderScreen({this.reminder});

  @override
  _AddEditReminderScreenState createState() => _AddEditReminderScreenState();
}

class _AddEditReminderScreenState extends State<AddEditReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _time;
  late String _priority;

  @override
  void initState() {
    super.initState();
    _title = widget.reminder?.title ?? '';
    _description = widget.reminder?.description ?? '';
    _time = widget.reminder?.time ?? DateTime.now();
    _priority = widget.reminder?.priority ?? 'Medium';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder == null ? 'Add Reminder' : 'Edit Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: ['High', 'Medium', 'Low'].map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final reminder = Reminder(
                      id: widget.reminder?.id ?? '',
                      title: _title,
                      description: _description,
                      time: _time,
                      priority: _priority,
                    );
                    if (widget.reminder == null) {
                      context
                          .read<ReminderBloc>()
                          .add(AddNewReminder(reminder));
                    } else {
                      context
                          .read<ReminderBloc>()
                          .add(EditExistingReminder(reminder));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.reminder == null ? 'Add' : 'Save'),
              ),
              if (widget.reminder != null)
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<ReminderBloc>()
                        .add(DeleteExistingReminder(widget.reminder!.id));
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
