import 'package:probe_report/measurement_parser.dart';
import 'package:probe_report/model/component.dart';
import 'package:probe_report/model/feature.dart';
import 'package:probe_report/model/measurement.dart';

class ComponentFeatureParser {
  final RegExp componentRegExp = new RegExp(r'COMPONENT NO (\d*)\s*FEATURE NO (\d*)');
  final RegExp workOffsetRegExp = new RegExp(r'WORK OFFSET (.*)');

  final MeasurementParser measurementParser;

  ComponentFeatureParser(this.measurementParser);

  Component parse(final String componentText) {
    int componentNumber;
    int featureNumber;
    String workOffset;
    List<Measurement> measurements = [];
    for (final String rawLine in componentText.split('\n')) {
      final String line = rawLine.trim();
      if (line.isEmpty || line.startsWith("-" * 10)) {
        continue;
      }

      if (componentRegExp.hasMatch(line)) {
        var componentMatch = componentRegExp.firstMatch(line);
        componentNumber = int.parse(componentMatch.group(1));
        featureNumber = int.parse(componentMatch.group(2));
      } else if (workOffsetRegExp.hasMatch(line)) {
        workOffset = workOffsetRegExp.firstMatch(line).group(1);
      } else {
        final Measurement measurement = measurementParser.parse(line);
        if (measurement != null) {
          measurements.add(measurement);
        } else {
          print("ERROR: Failed to parse measurement: $line");
        }
      }
    }

    if (componentNumber != null && workOffset != null && measurements.isNotEmpty) {
      final Feature feature = new Feature(featureNumber, workOffset);
      feature.measurements.addAll(measurements);
      return new Component(componentNumber, [feature]);
    }

    return null;
  }
}
