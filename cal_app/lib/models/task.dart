final String tableTasks = 'tasks';

class TaskFields {
  static final List<String> values = [
    id, repeatDelay, dueDate, name, description, completed
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String repeatDelay = 'repeatDelay';
  static final String dueDate = 'dueDate';
  static final String completed = 'completed';
}

//Sets the variables of an event.
class Task {
  final int? id;
  final int repeatDelay;
  final DateTime dueDate;
  final String name;
  final String description;
  final int completed;

  const Task({
    this.id,
    required this.repeatDelay,
    required this.dueDate,
    required this.name,
    required this.description,
    required this.completed,
  });

  Map<String, Object?> toMap() => {
    TaskFields.id: id,
    TaskFields.repeatDelay: repeatDelay.toString(),
    TaskFields.dueDate: dueDate.toIso8601String(),
    TaskFields.name: name,
    TaskFields.description: description,
    TaskFields.completed: completed,
  };

  static Task fromMap(Map<String, Object?> map) => Task(
      id: map[TaskFields.id] as int?,
      repeatDelay: int.parse(map[TaskFields.repeatDelay] as String),
      dueDate: DateTime.parse(map[TaskFields.dueDate] as String),
      name: map[TaskFields.name] as String,
      description: map[TaskFields.description] as String,
      completed: int.parse(map[TaskFields.completed] as String),
  );

  Task copy({
    int? id,
    int? taskDelay,
    DateTime? dueDate,
    String? name,
    String? description,
    int? completed,
  }) => Task(
    id: id ?? this.id,
    repeatDelay: taskDelay ?? this.repeatDelay,
    dueDate:  dueDate ?? this.dueDate,
    name: name ?? this.name,
    description: description ?? this.description,
    completed: completed ?? this.completed,
  );
}