final String tableSettings = 'settings';

class SettingsFields {
  static final List<String> values = [
    theme
  ];

  static final String theme = 'theme';
}

//Sets the variables of an event.
class Settings {
  final int theme;

  const Settings({
    required this.theme,
  });

  Map<String, Object?> toMap() => {
    SettingsFields.theme: theme,
  };

  static Settings fromMap(Map<String, Object?> map) => Settings(
      theme: int.parse(map[SettingsFields.theme] as String),
  );

  Settings copy({
    int? theme
  }) => Settings(
    theme: theme ?? this.theme,
  );
  }