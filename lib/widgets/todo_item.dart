import 'package:flutter/material.dart';
import 'package:my_app/crud/db_helper.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1, bottom: 1),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'haas',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontFamily: 'haas',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  int newStatus = _showCompleted ? 0 : 1;
                  await DbHelper.instance.updateStatus(id, newStatus);
                  _refreshTask();
                },
                icon: Icon(
                  _showCompleted ? Icons.check_circle : Icons.circle_outlined,
                  size: 32,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outlined,
                  size: 32,
                  color: Colors.black,
                ),
                onPressed: () => _confirmDelete(id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
