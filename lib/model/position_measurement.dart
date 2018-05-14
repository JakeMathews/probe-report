import 'package:probe_report/model/measurement.dart';

enum PositionAxis { X, Y, Z }

class PositionMeasurement extends Measurement {
  final PositionAxis positionAxis;

  PositionMeasurement(this.positionAxis, double expected, double actual, double deviation) : super(expected, actual, deviation);
}
