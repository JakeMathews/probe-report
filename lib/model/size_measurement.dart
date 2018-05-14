import 'package:probe_report/model/measurement.dart';

enum SizeType { DIAMETER }

class SizeMeasurement extends Measurement {
  final SizeType sizeType;

  SizeMeasurement(this.sizeType, double expected, double actual, double deviation) : super(expected, actual, deviation);
}
