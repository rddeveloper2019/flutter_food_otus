class MeasureUnit {
  int? id;
  final String one;
  final String few;
  final String many;
  static const asset = 'assets/fake/measure_units.json';
  MeasureUnit({
    required this.one,
    required this.few,
    required this.many,
    this.id,
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
