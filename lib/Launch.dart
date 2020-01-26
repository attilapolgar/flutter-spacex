class Launch {
  final bool success;
  final String name;

  Launch(this.success, this.name);

  Launch.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        success = json['success'];

  Map<String, dynamic> toJson() => {'success': success, 'name': name};
}
