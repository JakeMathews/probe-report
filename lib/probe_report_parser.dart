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
        addComponentToProbeReport(stringBuffer, probeReport);
        stringBuffer.clear();
        lineBreakCount = 1;
      }

      stringBuffer.writeln(line);
    }

    // End of lines. Remaining buffer is parsed
    addComponentToProbeReport(stringBuffer, probeReport);
    stringBuffer.clear();

    if (probeReport.components.isEmpty) {
      return null;
    }

    return probeReport;
  }

  void addComponentToProbeReport(final StringBuffer stringBuffer, final ProbeReport probeReport) {
    final Component component = componentFeatureParser.parse(stringBuffer.toString());

    if (component == null) {
      print("ERROR: Cannot parse component. Component is null");
      return;
    }

    if (probeReport.components.containsKey(component.componentNumber)) {
      probeReport.components[component.componentNumber].features.addAll(component.features);
    } else {
      probeReport.components[component.componentNumber] = component;
    }
  }
}
