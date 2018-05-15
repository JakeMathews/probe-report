import 'package:probe_report/component_feature_parser.dart';
import 'package:probe_report/measurement_parser.dart';
import 'package:probe_report/model/probe_report.dart';
import 'package:probe_report/probe_report_parser.dart';
import 'package:test/test.dart';

void main() {
  test('ProbeReportParser.parse(text)', () {
    final String probeResults = '''
Garbage text
-------------------------------------------------------------------
COMPONENT NO 4                   FEATURE NO 1
-------------------------------------------------------------------
WORK OFFSET S154
SIZE D3.2500   ACTUAL 3.2496   DEV -.0004
POSN X.0000   ACTUAL -.0001   DEV -.0001
POSN Y.0000   ACTUAL .0012   DEV .0012

-------------------------------------------------------------------
COMPONENT NO 4                   FEATURE NO 2
-------------------------------------------------------------------
WORK OFFSET S154
SIZE D3.2500   ACTUAL 3.2496   DEV -.0004
POSN X.0000   ACTUAL -.0001   DEV -.0001
POSN Y.0000   ACTUAL .0012   DEV .0012

-------------------------------------------------------------------
COMPONENT NO 5                   FEATURE NO 1
-------------------------------------------------------------------
WORK OFFSET S154
SIZE D3.2500   ACTUAL 3.2496   DEV -.0004
POSN X.0000   ACTUAL -.0001   DEV -.0001
POSN Y.0000   ACTUAL .0012   DEV .0012
    ''';
    final invalidProbeReportText = "This is not a valid probe report";

    // TODO: Provide fake ComponentFeatureParser
    final ProbeReportParser probeReportParser = new ProbeReportParser(new ComponentFeatureParser(new MeasurementParser()));
    final ProbeReport actual = probeReportParser.parse(probeResults);
    final ProbeReport invalidProbeReport = probeReportParser.parse(invalidProbeReportText);

    // TODO: Separate invalid text tests
    expect(invalidProbeReport, isNull);

    expect(actual, isNotNull);
    expect(actual.components, isNotEmpty);
    expect(actual.components.length, 2);

    expect(actual.components, contains(4));
    expect(actual.components[4].componentNumber, 4);
    expect(actual.components[4].features, isNotEmpty);
    expect(actual.components[4].features.length, 2);

    expect(actual.components, contains(5));
    expect(actual.components[5].componentNumber, 5);
    expect(actual.components[5].features, isNotEmpty);
    expect(actual.components[5].features.length, 1);
  });
}
