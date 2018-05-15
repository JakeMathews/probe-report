import 'package:probe_report/component_feature_parser.dart';
import 'package:probe_report/measurement_parser.dart';
import 'package:probe_report/model/component.dart';
import 'package:probe_report/model/feature.dart';
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
    // TODO: Provide fake MeasurementParser
    final ComponentFeatureParser componentFeatureParser = new ComponentFeatureParser(new MeasurementParser());
    final Component actual = componentFeatureParser.parse(componentText);

    expect(actual, isNotNull);
    expect(actual.componentNumber, 4);
    expect(actual.features, isNotEmpty);
    expect(actual.features.length, 1);

    final Feature actualFeature = actual.features[0];
    expect(actualFeature, isNotNull);
    expect(actualFeature.featureNumber, 1);
    expect(actualFeature.workOffset, "S154");
    expect(actualFeature.measurements, isNotNull);
    expect(actualFeature.measurements, isNotEmpty);
    expect(actualFeature.measurements.length, 3);
  });
}
