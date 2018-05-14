enum MeasurementType { SIZE, POSITION }

class Measurement {
  final MeasurementType measurementType;
  final double expected;
  final double actual;
  final double deviation;

  Measurement(this.measurementType, this.expected, this.actual, this.deviation);
}
