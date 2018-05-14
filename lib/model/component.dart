import 'package:probe_report/model/feature.dart';

class Component {
  final int componentNumber;
  final Map<int, Feature> features;

  Component(this.componentNumber, this.features);
}
