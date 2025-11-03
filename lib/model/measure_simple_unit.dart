class MeasureSimpleUnit {
  final int id;
  final String unit;
  static const asset = 'assets/fake/measure_simple_units.json';

  MeasureSimpleUnit({required this.id, required this.unit});

  factory MeasureSimpleUnit.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final unit = json['unit'] as String;

    return MeasureSimpleUnit(id: id, unit: unit);
  }

  @override
  String toString() {
    return unit;
  }
}
