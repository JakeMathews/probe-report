import 'dart:io';

import 'package:probe_report/probe_report.dart';

abstract class Exporter {
  export(ProbeReport probeReport, Directory destinationDirectory);
}
