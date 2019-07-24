import 'package:intl/intl.dart';

/// A mixin defined some helper methods are used to manipulate date
mixin DateHelper {
  /// Returns a [DateTime] instance convert from seconds since UTC.
  DateTime dateTimeFromSeconds(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  /// Returns a string convert from [DateTime] instance with specified format.
  /// The default format is 'yyy-MM-dd'.
  String formatDateTime(DateTime dateTime, {String format = 'yyy-MM-dd'}) =>
      DateFormat(format).format(dateTime);
}
