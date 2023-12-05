class Status {
  final String name;
  final int value;

  const Status({
    required this.name,
    required this.value,
  });

  factory Status.fromMap(Map<String, dynamic> json) {
    return Status(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }
}
