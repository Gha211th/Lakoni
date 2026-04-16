import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextEditingController descEditingController;
  final DateTime? selectedDate;
  final VoidCallback onPickDate;

  const TodoForm({
    super.key,
    required this.textEditingController,
    required this.descEditingController,
    required this.selectedDate,
    required this.onPickDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
                controller: textEditingController,
                readOnly: false,
                decoration: InputDecoration(
                  hintText: 'Add Some Task/List...',
                  hintStyle: TextStyle(
                    fontFamily: 'haas',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => onPickDate(),
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: selectedDate == null ? Colors.black : Colors.black,
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
            if (selectedDate != null)
              Padding(
                padding: EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  "Target Date: ${DateFormat('yMMMd').format(selectedDate!)}",
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Desc (Optional)",
              style: TextStyle(
                fontFamily: 'haas',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            TextField(
              controller: descEditingController,
              maxLines: 3,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Add Description",
                hintStyle: TextStyle(
                  fontFamily: 'haas',
                  color: Colors.black,
                  fontSize: 14,
                ),
                alignLabelWithHint: true,
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
          ],
        ),
      ],
    );
  }
}
