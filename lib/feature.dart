import 'package:probe_report/measurement.dart';

class Feature {
  final int featureNumber;
  final String workOffset;
  final List<Measurement> measurements;

  Feature(this.featureNumber, this.workOffset, this.measurements);
}
