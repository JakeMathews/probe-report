import 'package:probe_report/measurement_parser.dart';
import 'package:probe_report/model/measurement.dart';
import 'package:probe_report/model/position_measurement.dart';
import 'package:probe_report/model/size_measurement.dart';
import 'package:test/test.dart';

void main() {
  final MeasurementParser measurementParser = new MeasurementParser();

  final String sizeMeasurementText = 'SIZE D3.2500   ACTUAL 3.2496   DEV -.0004';
  final String sizeMeasurementNanText = 'SIZE D3.2500   ACTUAL NaN   DEV NaN';
  final String positionMeasurementXText = 'POSN X.0000   ACTUAL -.0001   DEV -.0001';
  final String positionMeasurementYText = 'POSN Y.0000   ACTUAL .0012   DEV .0012';
  final String positionMeasurementZText = 'POSN Z1.25   ACTUAL 1.2567   DEV .0067';
  final String positionMeasurementNanText = 'POSN Y.0000   ACTUAL NaN   DEV NaN';
  final String invalidSizeTypeText = 'SIZE Q1.25   ACTUAL 1.2567   DEV .0067';
  final String invalidPositionTypeText = 'POSN Q1.25   ACTUAL 1.2567   DEV .0067';
  final String notMeasurementText = 'I am not a measurement';

  test('size normal', () {
    final SizeMeasurement sizeMeasurement = measurementParser.parse(sizeMeasurementText);
    expect(sizeMeasurement, isNotNull);
    expect(sizeMeasurement.sizeType, SizeType.DIMENSION);
    expect(sizeMeasurement.expected, 3.25);
    expect(sizeMeasurement.actual, 3.2496);
    expect(sizeMeasurement.deviation, -0.0004);
  });

  test('size NaN', () {
    final SizeMeasurement nanSizeMeasurement = measurementParser.parse(sizeMeasurementNanText);
    expect(nanSizeMeasurement, isNotNull);
    expect(nanSizeMeasurement.sizeType, SizeType.DIMENSION);
    expect(nanSizeMeasurement.expected, 3.25);
    expect(nanSizeMeasurement.actual.isNaN, true);
    expect(nanSizeMeasurement.deviation.isNaN, true);
  });

  test('size invalid', () {
    final SizeMeasurement invalidSizeType = measurementParser.parse(invalidSizeTypeText);
    expect(invalidSizeType, isNotNull);
    expect(invalidSizeType.sizeType, SizeType.DIMENSION);
    expect(invalidSizeType.expected, 1.25);
    expect(invalidSizeType.actual, 1.2567);
    expect(invalidSizeType.deviation, .0067);
  });

  test('position X', () {
    final PositionMeasurement xPosMeasurement = measurementParser.parse(positionMeasurementXText);
    expect(xPosMeasurement, isNotNull);
    expect(xPosMeasurement.positionAxis, PositionAxis.X);
    expect(xPosMeasurement.expected, 0.0);
    expect(xPosMeasurement.actual, -0.0001);
    expect(xPosMeasurement.deviation, -0.0001);
  });

  test('position Y', () {
    final PositionMeasurement yPosMeasurement = measurementParser.parse(positionMeasurementYText);
    expect(yPosMeasurement, isNotNull);
    expect(yPosMeasurement.positionAxis, PositionAxis.Y);
    expect(yPosMeasurement.expected, 0.0);
    expect(yPosMeasurement.actual, 0.0012);
    expect(yPosMeasurement.deviation, 0.0012);
  });

  test('position Z', () {
    final PositionMeasurement zPosMeasurement = measurementParser.parse(positionMeasurementZText);
    expect(zPosMeasurement, isNotNull);
    expect(zPosMeasurement.positionAxis, PositionAxis.Z);
    expect(zPosMeasurement.expected, 1.25);
    expect(zPosMeasurement.actual, 1.2567);
    expect(zPosMeasurement.deviation, .0067);
  });

  test('posisition NaN', () {
    final PositionMeasurement nanPosMeasurement = measurementParser.parse(positionMeasurementNanText);
    expect(nanPosMeasurement, isNotNull);
    expect(nanPosMeasurement.positionAxis, PositionAxis.Y);
    expect(nanPosMeasurement.expected, 0.0);
    expect(nanPosMeasurement.actual.isNaN, true);
    expect(nanPosMeasurement.deviation.isNaN, true);
  });

  test('position invalid', () {
    final PositionMeasurement invalidPositionType = measurementParser.parse(invalidPositionTypeText);
    expect(invalidPositionType, isNotNull);
    expect(invalidPositionType.positionAxis, PositionAxis.X);
    expect(invalidPositionType.expected, 1.25);
    expect(invalidPositionType.actual, 1.2567);
    expect(invalidPositionType.deviation, .0067);
  });

  test('invalid', () {
    final Measurement notMeasurement = measurementParser.parse(notMeasurementText);
    expect(notMeasurement, isNull);
  });
}
