import 'package:probe_report/model/measurement.dart';

class Feature {
  final int featureNumber;
  final String workOffset;
  final List<Measurement> measurements = [];

  Feature(this.featureNumber, this.workOffset);
}
