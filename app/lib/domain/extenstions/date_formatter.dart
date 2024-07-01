import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:style/extenstions/date_extenstions.dart';
import 'package:yourspace_flutter/domain/extenstions/context_extenstions.dart';

enum DateFormatType {
  w,
  weekShort,
  month,
  relativeMonth,
  dayMonth,
  dayMonthFull,
  monthYear,
  monthDayYear,
  dayMonthYear,
  year,
  time,
  pastTime,
  relativeTime,
  relativeDate,
  relativeDateWeekday,
  serverIso
}

enum DateRangeFormatType {
  monthYear,
  relativeDate,
  dayMonthYear,
}

extension DateFormatter on DateTime {
  String format(BuildContext context, DateFormatType type) {
    if (isUtc) return toLocal().format(context, type);

    switch (type) {
      case DateFormatType.w:
        return DateFormat('E').format(this).substring(0, 1);
      case DateFormatType.weekShort:
        return DateFormat('EEE').format(this);
      case DateFormatType.month:
        return DateFormat('MMMM').format(this);
      case DateFormatType.relativeMonth:
        return year == DateTime.now().year
            ? format(context, DateFormatType.month)
            : format(context, DateFormatType.monthYear);
      case DateFormatType.dayMonth:
        return DateFormat('dd MMM').format(this);
      case DateFormatType.dayMonthFull:
        return DateFormat('dd MMMM').format(this);
      case DateFormatType.monthYear:
        return DateFormat('MMMM yyyy').format(this);
      case DateFormatType.monthDayYear:
        return DateFormat('MMM dd, yyyy').format(this);
      case DateFormatType.dayMonthYear:
        return DateFormat('dd MMM yyyy').format(this);
      case DateFormatType.year:
        return DateFormat('yyyy').format(this);
      case DateFormatType.time:
        final is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
        return DateFormat(is24HourFormat ? 'HH:mm' : 'hh:mm a')
            .format(toLocal());
      case DateFormatType.relativeTime:
        return _relativeTime(context);
      case DateFormatType.relativeDate:
        return _relativeDate(context, false);
      case DateFormatType.relativeDateWeekday:
        return _relativeDate(context, true);
      case DateFormatType.pastTime:
        return _formattedPastTime(context);
      case DateFormatType.serverIso:
        return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(toUtc());
    }
  }

  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;

  static String formatDateRange({
    required BuildContext context,
    required DateTime startDate,
    required DateTime endDate,
    DateRangeFormatType formatType = DateRangeFormatType.relativeDate,
  }) {
    if (startDate.startOfDay.isAtSameMomentAs(endDate.startOfDay)) {
      if (DateRangeFormatType.relativeDate == formatType) {
        return startDate.format(context, DateFormatType.relativeDate);
      } else if (DateRangeFormatType.monthYear == formatType) {
        return startDate.format(context, DateFormatType.monthYear);
      } else {
        return startDate.format(context, DateFormatType.dayMonthYear);
      }
    } else {
      if (DateRangeFormatType.relativeDate == formatType) {
        return '${startDate.format(context, DateFormatType.relativeDate)} - ${endDate.format(context, DateFormatType.relativeDate)}';
      } else if (DateRangeFormatType.monthYear == formatType) {
        return '${startDate.format(context, DateFormatType.monthYear)} - ${endDate.format(context, DateFormatType.monthYear)}';
      } else {
        if (startDate.year == endDate.year) {
          return '${startDate.format(context, DateFormatType.dayMonth)} - ${endDate.format(context, DateFormatType.dayMonthYear)}';
        } else {
          return '${startDate.format(context, DateFormatType.dayMonthYear)} - ${endDate.format(context, DateFormatType.dayMonthYear)}';
        }
      }
    }
  }

  String _relativeDate(BuildContext context, bool includeWeekday) {
    final today = DateTime.now();
    final yesterday = today.add(const Duration(days: -1));

    if (isSameDay(today)) {
      return context.l10n.common_today;
    } else if (isSameDay(yesterday)) {
      return context.l10n.common_yesterday;
    } else if (year == today.year) {
      return DateFormat('${includeWeekday ? 'EEEE, ' : ''}d MMMM').format(this);
    } else {
      return DateFormat('${includeWeekday ? 'EEEE, ' : ''}d MMM yyyy')
          .format(this);
    }
  }

  String _formattedPastTime(BuildContext context) {
    final DateTime currentTime = DateTime.now();

    if (isToday) {
      final int dateSeconds = millisecondsSinceEpoch ~/ 1000;
      final int currentTimeSeconds = currentTime.millisecondsSinceEpoch ~/ 1000;

      if ((currentTimeSeconds - dateSeconds) < 60) {
        return context.l10n.common_just_now;
      } else if ((currentTimeSeconds - dateSeconds) < (60 * 60)) {
        final int minutesAgo = (currentTimeSeconds - dateSeconds) ~/ 60;
        return '$minutesAgo ${context.l10n.common_min_ago}';
      } else {
        final int hoursAgo = (currentTimeSeconds - dateSeconds) ~/ (60 * 60);

        if (hoursAgo < 2) {
          return '$hoursAgo ${context.l10n.common_hour_ago}';
        } else {
          return '$hoursAgo ${context.l10n.common_hours_ago}';
        }
      }
    } else if (isYesterday) {
      return context.l10n.common_yesterday;
    } else {
      final bool isSameYear = year == currentTime.year;

      final String format =
      isSameYear ? 'dd MMM' : 'dd MMM yyyy';
      return DateFormat(format).format(this);
    }
  }

  String _relativeTime(BuildContext context) {
    final time = format(context, DateFormatType.time);

    final today = DateTime.now();
    final yesterday = today.add(const Duration(days: -1));

    final String day;
    if (isSameDay(today)) {
      day = 'Today';
    } else if (isSameDay(yesterday)) {
      day = 'Yesterday';
    } else if (year == today.year) {
      day = DateFormat('d MMM').format(this);
    } else {
      day = DateFormat('d MMM yyyy').format(this);
    }
    return '$day, $time';
  }

  bool get isToday => startOfDay.isAtSameMomentAs(DateTime.now().startOfDay);

  bool get isYesterday => startOfDay.isAtSameMomentAs(
    DateTime.now().startOfDay.subtract(const Duration(days: 1)),
  );
}

extension StringDateFormatter on String {
  String convertTo12HrTime() => DateFormat("hh:mm a")
      .format(DateFormat("HH:mm").parse(this))
      .toLowerCase();
}
