/// A mixin defined some helper methods are used to convert data
mixin ConvertHelper {
  /// Returns a DateTime instance convert from seconds since UTC
  DateTime dateTimeFromSeconds(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}
