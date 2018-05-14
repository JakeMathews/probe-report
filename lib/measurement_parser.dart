import 'package:probe_report/model/measurement.dart';
import 'package:probe_report/model/position_measurement.dart';
import 'package:probe_report/model/size_measurement.dart';

class MeasurementParser {
  final RegExp sizeMeasurementRegExp = new RegExp(r'SIZE (\w)' // Group 1 - Size Type
      r'([NaN|\d|\.|-]*)' // Group 2 - Expected Size
      r'\s*ACTUAL ([NaN|\d|\.|-]*)' // Group 3 - Actual Size
      r'\s*DEV ([NaN|\d|\.|-]*)'); // Group 4 - Deviation

  final RegExp positionMeasurementRegExp = new RegExp(r'POSN (\w)' // Group 1 - Position Axis
      r'([NaN|\d|\.|-]*)' // Group 2 - Expected Position
      r'\s*ACTUAL ([NaN|\d|\.|-]*)' // Group 3 - Actual Position
      r'\s*DEV ([NaN|\d|\.|-]*)'); // Group 4 - Deviation

  Measurement parse(final String measurementText) {
    Measurement measurement;

    final String line = measurementText.trim();
    if (sizeMeasurementRegExp.hasMatch(line)) {
      measurement = sizeMeasurementFromMatch(sizeMeasurementRegExp.firstMatch(line));
    } else if (positionMeasurementRegExp.hasMatch(line)) {
      measurement = positionMeasurementFromMatch(positionMeasurementRegExp.firstMatch(line));
    }

    return measurement;
  }

  SizeMeasurement sizeMeasurementFromMatch(final Match match) {
    final double expected = double.parse(match.group(2));
    final double actual = double.parse(match.group(3));
    final double deviation = double.parse(match.group(4));

    SizeType sizeType;
    switch (match.group(1)) {
      case 'D':
        sizeType = SizeType.DIMENSION;
        break;
      default:
        sizeType = SizeType.DIMENSION;
        print("WARNING: SizeType [${match.group(1)}] is undefined. Defaulting to $sizeType");
        break;
    }

    return new SizeMeasurement(sizeType, expected, actual, deviation);
  }

  PositionMeasurement positionMeasurementFromMatch(final Match match) {
    final double expected = double.parse(match.group(2));
    final double actual = double.parse(match.group(3));
    final double deviation = double.parse(match.group(4));

    PositionAxis positionAxis;
    switch (match.group(1)) {
      case 'X':
        positionAxis = PositionAxis.X;
        break;
      case 'Y':
        positionAxis = PositionAxis.Y;
        break;
      case 'Z':
        positionAxis = PositionAxis.Z;
        break;
      default:
        positionAxis = PositionAxis.X;
        print("WARNING: PositionType [${match.group(1)}] is undefined. Defaulting to $positionAxis");
        break;
    }

    return new PositionMeasurement(positionAxis, expected, actual, deviation);
  }
}
