import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/crud/db_model.dart';
import 'package:my_app/font/reponsive_font.dart';
import 'package:my_app/crud/db_helper.dart';
import 'package:my_app/widgets/todo_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _showCompleted = false;

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

  void _refreshTask() {
    setState(() {});
  }

  Future<void> _addTask() async {
    if (_taskController.text.isNotEmpty) {
      Todo newTask = Todo(
        name: _taskController.text,
        date: _selectedDate != null
            ? DateFormat('yMMMd').format(_selectedDate!)
            : DateFormat('yMMMd').format(DateTime.now()),
        desc: _descController.text,
        isDone: 0,
      );

      await DbHelper.instance.create(newTask.toMap());

      _taskController.clear();
      _descController.clear();
      setState(() {
        _selectedDate = null;
      });
      _refreshTask();
    }
  }

  void _showTaskDetail(String title, String desc, String date) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'haas',
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    desc,
                    style: TextStyle(
                      fontFamily: 'haas',
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'haas',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'close',
                style: TextStyle(
                  fontFamily: 'haas',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
          title: const Text(
            'Delete Task?',
            style: TextStyle(
              fontFamily: 'haas',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Apakah ingin menghapus tugas ini?',
              style: TextStyle(fontFamily: 'haas', fontSize: 18),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'cancel',
                style: TextStyle(
                  fontFamily: 'haas',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await DbHelper.instance.delete(id);
                Navigator.pop(context);
                _refreshTask();
              },
              child: const Text(
                'delete',
                style: TextStyle(
                  fontFamily: 'haas',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: width * 0.08),
          child: Column(
            children: [
              _buildHeaderTitle(),
              TodoForm(
                textEditingController: _taskController,
                descEditingController: _descController,
                selectedDate: _selectedDate,
                onPickDate: () => _pickDate(context),
              ),
              const SizedBox(height: 10),
              _buildButton(),
              const SizedBox(height: 25),
              const Divider(thickness: 3, color: Colors.black),
              const SizedBox(height: 10),
              _buildToggleStatus(),
              _buildCardSession(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Column(
          children: [
            Text(
              "Lakoni.",
              style: TextStyle(
                fontFamily: 'haas',
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveFont.getFontSizeForHeader(context),
                height: 1,
              ),
            ),
            Text(
              '"Nggawe Urip Luwih Ketata"',
              style: TextStyle(
                fontFamily: 'haas',
                fontSize: ResponsiveFont.getFontsizeSub(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: _addTask,
      child: Container(
        height: 55,
        width: width * 1.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Add To List",
            style: TextStyle(
              fontFamily: 'haas',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(String title, String desc, String date, int id) {
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

  Widget _buildCardSession() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<Map<String, dynamic>>>(
          future: DbHelper.instance.queryAllRows(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            final allTask = snapshot.data!;
            final filteredTask = allTask.where((task) {
              return task['is_done'] == (_showCompleted ? 1 : 0);
            }).toList();

            if (filteredTask.isEmpty) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'data is empty',
                        style: TextStyle(
                          fontFamily: 'haas',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredTask.length,
                  itemBuilder: (context, index) {
                    var item = filteredTask[index];
                    String title = item['name'] ?? '';
                    String desc = item['desc'] ?? '';
                    String date = item['date'] ?? '';
                    int id = item['id'];

                    return InkWell(
                      onTap: () => _showTaskDetail(title, desc, date),
                      borderRadius: BorderRadius.circular(10),
                      child: _buildCardItem(title, desc, date, id),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildToggleStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _showCompleted ? 'Finished List~' : 'Your Unchecked List~',
          style: TextStyle(
            fontFamily: 'haas',
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        Switch(
          value: _showCompleted,
          activeColor: Colors.black,
          activeTrackColor: Colors.white,
          inactiveThumbColor: Colors.black,
          inactiveTrackColor: Colors.white,
          trackOutlineColor: WidgetStateProperty.all(Colors.black),
          onChanged: (value) {
            setState(() {
              _showCompleted = value;
            });
          },
        ),
      ],
    );
  }
}
