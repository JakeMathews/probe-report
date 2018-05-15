import 'dart:io';

import 'package:probe_report/exporters/exporter.dart';
import 'package:probe_report/model/probe_report.dart';

class CSVExporter extends Exporter {
  @override
  export(final ProbeReport probeReport, final Directory destinationDirectory) {
    print(probeReport);
  }
}
