import 'package:intl/intl.dart';

/// 日期格式化工具类
class DateFormatter {
  /// 格式化日期为 yyyy-MM-dd
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// 格式化为中文日期
  static String formatChineseDate(DateTime date) {
    return DateFormat('yyyy年MM月dd日').format(date);
  }

  /// 格式化为相对时间描述
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    final difference = targetDate.difference(today).inDays;

    if (difference == 0) {
      return '今天';
    } else if (difference == 1) {
      return '明天';
    } else if (difference == -1) {
      return '昨天';
    } else if (difference > 0) {
      return '还有 $difference 天';
    } else {
      return '${-difference} 天前';
    }
  }

  /// 计算年龄或经过的年数（智能显示）
  static String formatYearsPassed(DateTime date) {
    final now = DateTime.now();
    final targetDate = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);

    // 如果是今天
    if (targetDate.isAtSameMomentAs(today)) {
      return '今天';
    }

    // 如果是未来日期，简单显示天数
    if (targetDate.isAfter(today)) {
      final days = targetDate.difference(today).inDays;
      if (days == 1) return '明天';
      if (days <= 7) return '$days天';
      if (days <= 30) return '$days天';
      if (days < 365) {
        final months = (days / 30).floor();
        final remainingDays = days % 30;
        if (months > 0 && remainingDays > 0) {
          return '$months个月$remainingDays天';
        } else if (months > 0) {
          return '$months个月';
        }
        return '$days天';
      }
      final years = (days / 365).floor();
      return '$years年';
    }

    // 如果是过去日期，计算实际经过的时间
    final difference = today.difference(targetDate);
    return formatTimeDifference(difference, isFuture: false);
  }

  /// 格式化时间差（智能显示年月日时分秒）
  static String formatTimeDifference(
    Duration duration, {
    bool isFuture = false,
  }) {
    final days = duration.inDays.abs();
    final hours = duration.inHours.abs();
    final minutes = duration.inMinutes.abs();
    final seconds = duration.inSeconds.abs();

    // 超过365天显示年
    if (days >= 365) {
      final years = (days / 365).floor();
      final remainingDays = days % 365;
      if (remainingDays > 30) {
        final months = (remainingDays / 30).floor();
        return '$years年$months个月';
      } else if (remainingDays > 0) {
        return '$years年$remainingDays天';
      }
      return '$years年';
    }

    // 超过30天显示月
    if (days >= 30) {
      final months = (days / 30).floor();
      final remainingDays = days % 30;
      if (remainingDays > 0) {
        return '$months个月$remainingDays天';
      }
      return '$months个月';
    }

    // 超过1天显示天
    if (days >= 1) {
      final remainingHours = hours % 24;
      if (remainingHours > 0) {
        return '$days天$remainingHours小时';
      }
      return '$days天';
    }

    // 超过1小时显示小时
    if (hours >= 1) {
      final remainingMinutes = minutes % 60;
      if (remainingMinutes > 0) {
        return '$hours小时$remainingMinutes分钟';
      }
      return '$hours小时';
    }

    // 超过1分钟显示分钟
    if (minutes >= 1) {
      final remainingSeconds = seconds % 60;
      if (remainingSeconds > 0) {
        return '$minutes分钟$remainingSeconds秒';
      }
      return '$minutes分钟';
    }

    // 显示秒
    return '$seconds秒';
  }

  /// 获取星期几
  static String getWeekday(DateTime date) {
    final weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[date.weekday - 1];
  }

  /// 计算距离下一个纪念日的描述
  static String getNextAnniversaryDescription(DateTime originalDate) {
    final now = DateTime.now();
    DateTime nextDate = DateTime(
      now.year,
      originalDate.month,
      originalDate.day,
    );

    if (nextDate.isBefore(now)) {
      nextDate = DateTime(now.year + 1, originalDate.month, originalDate.day);
    }

    final days = nextDate.difference(now).inDays;

    if (days == 0) {
      return '今天！';
    } else if (days == 1) {
      return '明天';
    } else if (days <= 7) {
      return '还有 $days 天';
    } else if (days <= 30) {
      final weeks = (days / 7).floor();
      return '还有 $weeks 周';
    } else if (days <= 365) {
      final months = (days / 30).floor();
      return '还有 $months 个月';
    } else {
      return formatChineseDate(nextDate);
    }
  }
}
