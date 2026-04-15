class Todo {
  final int? id;
  final String name;
  final String date;
  final String desc;
  final int isDone;

  Todo({
    this.id,
    required this.name,
    required this.date,
    required this.desc,
    this.isDone = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'desc': desc,
      'is_done': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      desc: map['desc'],
      isDone: map['is_done'],
    );
  }
}
