import 'dart:io';

import 'package:probe_report/component_feature_parser.dart';
import 'package:probe_report/exporters/csv_exporter.dart';
import 'package:probe_report/measurement_parser.dart';
import 'package:probe_report/probe_report_parser.dart';

final MeasurementParser measurementParser = new MeasurementParser();
final ComponentFeatureParser componentFeatureParser = new ComponentFeatureParser(measurementParser);
final ProbeReportParser probeReportParser = new ProbeReportParser(componentFeatureParser);

main(final List<String> arguments) {
  if (arguments.length != 1) {
    print("Incorrect number of arguments. Please supply path to probe results");
    return;
  }

  var file = File(arguments[0]);
  file.exists().then((bool fileExists) {
    if (fileExists) {
      file.readAsString().then((String probeResults) {
        parse(probeResults, file.parent);
      });
    } else {
      print("Path to probe results does not exist: ${file.path}");
    }
  });
}

parse(final String probeResults, final Directory destinationDirectory) {
  var probeReport = probeReportParser.parse(probeResults);

  CSVExporter().export(probeReport, destinationDirectory);
}
