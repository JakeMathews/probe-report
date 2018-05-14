import 'package:probe_report/component_feature_parser.dart';
import 'package:probe_report/model/component.dart';
import 'package:probe_report/model/probe_report.dart';

class ProbeReportParser {
  final ComponentFeatureParser componentFeatureParser;

  ProbeReportParser(this.componentFeatureParser);

  ProbeReport parse(final String probeResults) {
    final ProbeReport probeReport = new ProbeReport();

    var lineBreakCount = 0;
    var stringBuffer = new StringBuffer();
    for (final String line in probeResults.split('\n')) {
      var isLineBreak = line.contains('-' * 67);
      if (isLineBreak) {
        lineBreakCount++;
      }

      if (lineBreakCount <= 0) {
        continue;
      } else if (lineBreakCount >= 3) {
        final Component component = componentFeatureParser.parse(stringBuffer.toString());
        if (probeReport.components.containsKey(component.componentNumber)) {
          probeReport.components[component.componentNumber].features.addAll(component.features);
        }
        stringBuffer.clear();
        lineBreakCount = 1;
      }

      stringBuffer.writeln(line);
    }

    return probeReport;
  }
}
