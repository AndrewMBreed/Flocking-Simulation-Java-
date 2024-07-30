final String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    id, name, description, dueDate
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String dueDate = 'dueDate';
  static final String repeatFrequency = 'repeatFrequency';
  //0 = never, 1 = weekly, 2 = bi-weekly, 3 = monthly, 4 = yearly
  static final String duration = 'duration';
  //in hours

}

//Sets the variables of an event.
class Event {
  final int? id;
  final String name;
  final String description;
  final int duration;
  final DateTime dueDate;
  final int repeatFrequency;

  const Event({
    this.id,
    required this.name,
    required this.description,
    required this.dueDate,
    required this.repeatFrequency,
    required this.duration,
  });

  Map<String, Object?> toMap() => {
    EventFields.id: id,
    EventFields.name: name,
    EventFields.description: description,
    EventFields.duration: duration.toString(),
    EventFields.dueDate: dueDate.toIso8601String(),
    EventFields.repeatFrequency: repeatFrequency.toString(),
  };

  static Event fromMap(Map<String, Object?> map) => Event(
    id: map[EventFields.id] as int?,
    name: map[EventFields.name] as String,
    description: map[EventFields.description] as String,
      duration: int.parse(map[EventFields.duration] as String),
    dueDate: DateTime.parse(map[EventFields.dueDate] as String),
    repeatFrequency: int.parse(map[EventFields.repeatFrequency] as String),
  );

  Event copy({
    int? id,
    String? priority,
    String? name,
    String? description,
    int? duration,
    DateTime? dueDate,
    int? repeatFrequency,
}) => Event(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    duration: duration ?? this.duration,
    dueDate: dueDate ?? this.dueDate,
    repeatFrequency: repeatFrequency ?? this.repeatFrequency,
  );
}