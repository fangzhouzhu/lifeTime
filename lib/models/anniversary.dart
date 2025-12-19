/// 纪念日模型
class Anniversary {
  final int? id;
  final String title;
  final DateTime date;
  final String? description;
  final String category; // 生日、恋爱、结婚、其他等
  final String? iconName;
  final int? color;
  final bool isLunar; // 是否为农历
  final bool reminder; // 是否提醒

  Anniversary({
    this.id,
    required this.title,
    required this.date,
    this.description,
    this.category = '其他',
    this.iconName,
    this.color,
    this.isLunar = false,
    this.reminder = true,
  });

  /// 计算距离今天的天数
  int get daysFromNow {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    return targetDate.difference(today).inDays;
  }

  /// 计算已经过去多少年
  int get yearsPassed {
    final now = DateTime.now();
    int years = now.year - date.year;
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {
      years--;
    }
    return years;
  }

  /// 获取下一个纪念日
  DateTime get nextAnniversary {
    final now = DateTime.now();
    DateTime next = DateTime(now.year, date.month, date.day);
    
    if (next.isBefore(now)) {
      next = DateTime(now.year + 1, date.month, date.day);
    }
    
    return next;
  }

  /// 从 Map 创建对象（用于数据库）
  factory Anniversary.fromMap(Map<String, dynamic> map) {
    return Anniversary(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      category: map['category'] ?? '其他',
      iconName: map['iconName'],
      color: map['color'],
      isLunar: map['isLunar'] == 1,
      reminder: map['reminder'] == 1,
    );
  }

  /// 转换为 Map（用于数据库）
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'category': category,
      'iconName': iconName,
      'color': color,
      'isLunar': isLunar ? 1 : 0,
      'reminder': reminder ? 1 : 0,
    };
  }

  /// 复制并修改
  Anniversary copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? description,
    String? category,
    String? iconName,
    int? color,
    bool? isLunar,
    bool? reminder,
  }) {
    return Anniversary(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
      iconName: iconName ?? this.iconName,
      color: color ?? this.color,
      isLunar: isLunar ?? this.isLunar,
      reminder: reminder ?? this.reminder,
    );
  }
}
