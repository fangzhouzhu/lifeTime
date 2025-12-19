import 'package:flutter/foundation.dart';
import '../models/anniversary.dart';
import '../services/database_service.dart';

/// 纪念日状态管理
class AnniversaryProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService.instance;
  List<Anniversary> _anniversaries = [];
  bool _isLoading = false;

  List<Anniversary> get anniversaries => _anniversaries;
  bool get isLoading => _isLoading;

  /// 获取即将到来的纪念日
  List<Anniversary> get upcomingAnniversaries {
    final sorted = List<Anniversary>.from(_anniversaries);
    sorted.sort((a, b) {
      final aDays = a.nextAnniversary.difference(DateTime.now()).inDays;
      final bDays = b.nextAnniversary.difference(DateTime.now()).inDays;
      return aDays.compareTo(bDays);
    });
    return sorted;
  }

  /// 按分类分组
  Map<String, List<Anniversary>> get anniversariesByCategory {
    final Map<String, List<Anniversary>> grouped = {};
    for (var anniversary in _anniversaries) {
      if (!grouped.containsKey(anniversary.category)) {
        grouped[anniversary.category] = [];
      }
      grouped[anniversary.category]!.add(anniversary);
    }
    return grouped;
  }

  /// 加载所有纪念日
  Future<void> loadAnniversaries() async {
    _isLoading = true;
    notifyListeners();

    try {
      _anniversaries = await _dbService.readAllAnniversaries();
    } catch (e) {
      debugPrint('加载纪念日失败: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 添加纪念日
  Future<void> addAnniversary(Anniversary anniversary) async {
    try {
      final newAnniversary = await _dbService.createAnniversary(anniversary);
      _anniversaries.add(newAnniversary);
      notifyListeners();
    } catch (e) {
      debugPrint('添加纪念日失败: $e');
      rethrow;
    }
  }

  /// 更新纪念日
  Future<void> updateAnniversary(Anniversary anniversary) async {
    try {
      await _dbService.updateAnniversary(anniversary);
      final index = _anniversaries.indexWhere((a) => a.id == anniversary.id);
      if (index != -1) {
        _anniversaries[index] = anniversary;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('更新纪念日失败: $e');
      rethrow;
    }
  }

  /// 删除纪念日
  Future<void> deleteAnniversary(int id) async {
    try {
      await _dbService.deleteAnniversary(id);
      _anniversaries.removeWhere((a) => a.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('删除纪念日失败: $e');
      rethrow;
    }
  }

  /// 搜索纪念日
  List<Anniversary> searchAnniversaries(String query) {
    if (query.isEmpty) return _anniversaries;
    
    final lowerQuery = query.toLowerCase();
    return _anniversaries.where((anniversary) {
      return anniversary.title.toLowerCase().contains(lowerQuery) ||
          (anniversary.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }
}
