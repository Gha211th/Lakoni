import 'package:flutter/material.dart';
import 'package:my_app/crud/db_helper.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final int id;

  final bool showCompleted;
  final VoidCallback onRefresh;
  final Function(int) delete;

  const TodoItem({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.id,
    required this.showCompleted,
    required this.onRefresh,
    required this.delete,
  });

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
          Expanded(
            child: Column(
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
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  int newStatus = showCompleted ? 0 : 1;
                  await DbHelper.instance.updateStatus(id, newStatus);
                  onRefresh();
                },
                icon: Icon(
                  showCompleted ? Icons.check_circle : Icons.circle_outlined,
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
                onPressed: () => delete(id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
