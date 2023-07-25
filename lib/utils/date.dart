bool isAfterOrEqualTo(DateTime date, DateTime dateTime) {
  final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
  return isAtSameMomentAs | date.isAfter(dateTime);
}

bool isBeforeOrEqualTo(DateTime date, DateTime dateTime) {
  final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
  return isAtSameMomentAs | date.isBefore(dateTime);
}

bool isBetween(
  DateTime date,
  DateTime fromDateTime,
  DateTime toDateTime,
) {
  final isAfter = isAfterOrEqualTo(date, fromDateTime);
  final isBefore = isBeforeOrEqualTo(date, toDateTime);
  return isAfter && isBefore;
}
