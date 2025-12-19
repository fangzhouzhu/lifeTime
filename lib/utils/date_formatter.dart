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

  /// 计算年龄或经过的年数
  static String formatYearsPassed(DateTime date) {
    final now = DateTime.now();
    int years = now.year - date.year;
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {
      years--;
    }

    if (years == 0) {
      final months = now.month - date.month;
      if (months <= 0) {
        final days = now.day - date.day;
        return '$days 天';
      }
      return '$months 个月';
    }

    return '$years 年';
  }

  /// 获取星期几
  static String getWeekday(DateTime date) {
    final weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[date.weekday - 1];
  }

  /// 计算距离下一个纪念日的描述
  static String getNextAnniversaryDescription(DateTime originalDate) {
    final now = DateTime.now();
    DateTime nextDate = DateTime(now.year, originalDate.month, originalDate.day);
    
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
