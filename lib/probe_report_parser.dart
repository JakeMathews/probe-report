import 'package:probe_report/probe_report.dart';

class ProbeReportParser {
  ProbeReport parse(final String probeResults) {
    final ProbeReport probeReport = new ProbeReport();

    for (final String line in probeResults.split('\n')) {}

    return probeReport;
  }
}
