import 'package:probe_report/component_feature_parser.dart';
import 'package:probe_report/model/component.dart';
import 'package:probe_report/model/feature.dart';
import 'package:probe_report/model/measurement.dart';
import 'package:test/test.dart';

void main() {
  test('ComponentFeatureParser().parse(text)', () {
    final String componentText = '''
-------------------------------------------------------------------
COMPONENT NO 4                   FEATURE NO 1
-------------------------------------------------------------------
WORK OFFSET S154
SIZE D3.2500   ACTUAL 3.2496   DEV -.0004
POSN X.0000   ACTUAL -.0001   DEV -.0001
POSN Y.0000   ACTUAL .0012   DEV .0012
    ''';
    final ComponentFeatureParser componentFeatureParser = new ComponentFeatureParser();
    final Component actual = componentFeatureParser.parse(componentText);

    expect(actual, isNotNull);
    expect(actual.componentNumber, 4);
    expect(actual.features, isNotEmpty);
    expect(actual.features, contains(1));

    final Feature actualFeature = actual.features[1];
    expect(actualFeature, isNotNull);
    expect(actualFeature.featureNumber, 1);
    expect(actualFeature.workOffset, "S154");
    expect(actualFeature.measurements, isNotNull);
    expect(actualFeature.measurements, isNotEmpty);

    final Measurement sizeMeasurement = actualFeature.measurements[0];
    expect(sizeMeasurement, isNotNull);
    expect(sizeMeasurement.measurementType, MeasurementType.SIZE);
    expect(sizeMeasurement.expected, 3.25);
    expect(sizeMeasurement.actual, 3.2496);
    expect(sizeMeasurement.deviation, -0.0004);

    final Measurement xPosMeasurement = actualFeature.measurements[0];
    expect(xPosMeasurement, isNotNull);
    expect(xPosMeasurement.measurementType, MeasurementType.POSITION);
    expect(xPosMeasurement.expected, 0.0);
    expect(xPosMeasurement.actual, -0.0001);
    expect(xPosMeasurement.deviation, -0.0001);

    final Measurement yPosMeasurement = actualFeature.measurements[0];
    expect(yPosMeasurement, isNotNull);
    expect(yPosMeasurement.measurementType, MeasurementType.POSITION);
    expect(yPosMeasurement.expected, 0.0);
    expect(yPosMeasurement.actual, -0.0012);
    expect(yPosMeasurement.deviation, -0.0012);
  });
}
