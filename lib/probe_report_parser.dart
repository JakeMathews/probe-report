import 'package:probe_report/component_feature_parser.dart';
import 'package:probe_report/model/probe_report.dart';

class ProbeReportParser {
  final ComponentFeatureParser componentFeatureParser;

  ProbeReportParser(this.componentFeatureParser);

  ProbeReport parse(final String probeResults) {
    final ProbeReport probeReport = new ProbeReport();

    for (final String line in probeResults.split('\n')) {}

    return probeReport;
  }
}
