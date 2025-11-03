class MeasureUnit {
  final int id;
  final String one;
  final String few;
  final String many;

  MeasureUnit({
    required this.id,
    required this.one,
    required this.few,
    required this.many,
  });

  factory MeasureUnit.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final one = json['one'] as String;
    final few = json['few'] as String;
    final many = json['many'] as String;

    return MeasureUnit(id: id, one: one, few: few, many: many);
  }

  @override
  String toString() {
    return one;
  }
}
