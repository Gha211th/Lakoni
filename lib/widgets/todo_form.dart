import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add Task/List....",
          style: TextStyle(
            fontFamily: 'haas',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Container(
          child: TextField(
            controller: _taskController,
            readOnly: false,
            decoration: InputDecoration(
              hintText: 'Add Some Task/List...',
              hintStyle: TextStyle(
                fontFamily: 'haas',
                color: Colors.black,
                fontSize: 14,
              ),
              suffixIcon: IconButton(
                onPressed: () => _pickDate(context),
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: _selectedDate == null ? Colors.black : Colors.black,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
        ),
        if (_selectedDate != null)
          Padding(
            padding: EdgeInsets.only(top: 8, left: 4),
            child: Text(
              "Target Date: ${DateFormat('yMMMd').format(_selectedDate!)}",
            ),
          ),
      ],
    );
  }
}
