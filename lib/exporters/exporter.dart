import 'dart:io';

import 'package:probe_report/model/probe_report.dart';

abstract class Exporter {
  export(ProbeReport probeReport, Directory destinationDirectory);
}
