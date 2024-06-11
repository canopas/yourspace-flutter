import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime max(DateTime a, DateTime b) => a.isAfter(b) ? a : b;

DateTime min(DateTime a, DateTime b) => a.isBefore(b) ? a : b;

enum DateRangeType {
  day,
  week,
  month,
  year;

  DateRangeType get previous {
    if (index == 0) return DateRangeType.day;
    return values[index - 1];
  }
}

extension DateTimeExtensions on DateTime {
  int get dayOfYear {
    return difference(DateTime(year, 1, 1)).inDays + 1;
  }

  String monthFormat() {
    return DateFormat('MMMM').format(this);
  }

  String monthAbbreviationFormat() {
    return DateFormat('MMM').format(this);
  }

  int get toUnix => millisecondsSinceEpoch ~/ 1000;

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => startOfDay
      .add(const Duration(days: 1))
      .subtract(const Duration(seconds: 1));

  DateTime get startOfWeek {
    final daysFromStartOfWeek = (weekday - 1) % 7;
    return subtract(Duration(days: daysFromStartOfWeek)).startOfDay;
  }

  DateTime get endOfWeek {
    final daysToEndOfWeek = 7 - weekday;
    return add(Duration(days: daysToEndOfWeek)).endOfDay;
  }

  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfMonth => DateTime(year, month + 1, 0).endOfDay;

  DateTime get startOfYear => DateTime(year, 1, 1);

  DateTime get endOfYear => DateTime(year, 12, 31).endOfDay;

  DateTime startOf(DateRangeType type) {
    switch (type) {
      case DateRangeType.day:
        return startOfDay;
      case DateRangeType.week:
        return startOfWeek;
      case DateRangeType.month:
        return startOfMonth;
      case DateRangeType.year:
        return startOfYear;
    }
  }

  DateTime endOf(DateRangeType type) {
    switch (type) {
      case DateRangeType.day:
        return endOfDay;
      case DateRangeType.week:
        return endOfWeek;
      case DateRangeType.month:
        return endOfMonth;
      case DateRangeType.year:
        return endOfYear;
    }
  }

  DateTime next(DateRangeType type) {
    switch (type) {
      case DateRangeType.day:
      // need the hours to have the correct date because of summer/winter time
        return startOfDay.add(const Duration(days: 1, hours: 12)).startOfDay;
      case DateRangeType.week:
      // need the hours to have the correct date because of summer/winter time
        return startOfDay.add(const Duration(days: 7, hours: 12)).startOfWeek;
      case DateRangeType.month:
        return DateTime(year, month + 1, 1);
      case DateRangeType.year:
        return DateTime(year + 1, 1, 1);
    }
  }

  DateTime previous(DateRangeType type) {
    switch (type) {
      case DateRangeType.day:
        return subtract(const Duration(days: 1)).startOfDay;
      case DateRangeType.week:
        return subtract(const Duration(days: 7)).startOfWeek;
      case DateRangeType.month:
        return DateTime(year, month - 1, 1);
      case DateRangeType.year:
        return DateTime(year - 1, 1, 1);
    }
  }

  DateTimeRange range(
      DateRangeType type, {
        DateTime? start,
        DateTime? maxEnd,
      }) =>
      DateTimeRange(
        start: start ?? startOf(type),
        end: maxEnd == null ? endOf(type) : min(endOf(type), maxEnd),
      );

  int get weekOfYear {
    final firstDay = startOfWeek;
    final weeks = firstDay.dayOfYear ~/ 7;
    final partial = firstDay.dayOfYear % 7 != 0;

    return weeks + (partial ? 1 : 0);
  }

  bool isSameDay(DateTime? date) => DateUtils.isSameDay(this, date);
  bool isAfterOrSameDay(DateTime? date) => (isAfter(date!) || isSameDay(date));
  bool isBeforeOrSameDay(DateTime? date) =>
      (isBefore(date!) || isSameDay(date));
}

extension DateTimeListExtensions on List<DateTime> {
  DateTime? get min => isEmpty ? null : reduce((a, b) => a.isBefore(b) ? a : b);

  DateTime? get max => isEmpty ? null : reduce((a, b) => a.isAfter(b) ? a : b);
}

extension DateTimeRangeExtensions on DateTimeRange {
  DateTimeRange next(DateRangeType type) => start.next(type).range(type);

  DateTimeRange previous(DateRangeType type) =>
      start.previous(type).range(type);

  List<DateTimeRange> ranges(DateRangeType type) {
    var currentStart = start;
    final list = <DateTimeRange>[];
    while (currentStart.isBefore(end)) {
      list.add(currentStart.range(type, start: currentStart, maxEnd: end));
      currentStart = currentStart.next(type);
    }
    return list;
  }

  bool contains(DateTime? dateTime) {
    if (dateTime == null) return false;
    return (dateTime.isAfter(start) || dateTime.isAtSameMomentAs(start)) &&
        (dateTime.isBefore(end) || dateTime.isAtSameMomentAs(end));
  }

  bool get isSameDay => start.day == end.day;

  DateTime get center {
    final startMilliseconds = start.millisecondsSinceEpoch;
    final endMilliseconds = end.millisecondsSinceEpoch;

    return DateTime.fromMillisecondsSinceEpoch(
      (startMilliseconds + endMilliseconds) ~/ 2,
    );
  }
}
