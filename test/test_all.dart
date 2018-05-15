import 'package:test/test.dart';

import 'component_feature_parser_test.dart' as component_feature_parser_test;
import 'measurement_parser_test.dart' as measurement_parser_test;
import 'probe_report_test.dart' as probe_report_test;

void main() {
  group("component_feature_parser_test", component_feature_parser_test.main);
  group("measurement_parser_test", measurement_parser_test.main);
  group("probe_report_test", probe_report_test.main);
}
