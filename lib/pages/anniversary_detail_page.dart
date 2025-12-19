import 'package:flutter/material.dart';
import '../models/anniversary.dart';
import '../utils/date_formatter.dart';
import '../theme/app_theme.dart';
import 'add_anniversary_page.dart';

/// 纪念日详情页面
class AnniversaryDetailPage extends StatelessWidget {
  final Anniversary anniversary;

  const AnniversaryDetailPage({
    super.key,
    required this.anniversary,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getCategoryColor(anniversary.category);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, color),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainInfo(color),
                  const SizedBox(height: 32),
                  _buildDetailsSection(),
                  const SizedBox(height: 24),
                  if (anniversary.description != null)
                    _buildDescriptionSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAnniversaryPage(
                anniversary: anniversary,
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color color) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          anniversary.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              AppTheme.getCategoryIcon(anniversary.category),
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo(Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  '已过',
                  DateFormatter.formatYearsPassed(anniversary.date),
                  color,
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.grey[300],
                ),
                _buildInfoItem(
                  '距今',
                  '${DateTime.now().difference(anniversary.date).inDays} 天',
                  color,
                ),
              ],
            ),
            const Divider(height: 32),
            _buildNextAnniversary(color),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildNextAnniversary(Color color) {
    final nextDate = anniversary.nextAnniversary;
    final daysUntil = nextDate.difference(DateTime.now()).inDays;
    
    return Column(
      children: [
        Text(
          '下一个纪念日',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          DateFormatter.formatChineseDate(nextDate),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          daysUntil == 0 ? '就是今天！' : '还有 $daysUntil 天',
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '详细信息',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              Icons.calendar_today,
              '日期',
              DateFormatter.formatChineseDate(anniversary.date),
            ),
            const Divider(),
            _buildDetailRow(
              Icons.category,
              '分类',
              anniversary.category,
            ),
            const Divider(),
            _buildDetailRow(
              Icons.calendar_month,
              '日历类型',
              anniversary.isLunar ? '农历' : '公历',
            ),
            const Divider(),
            _buildDetailRow(
              Icons.notifications,
              '提醒',
              anniversary.reminder ? '开启' : '关闭',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '描述',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              anniversary.description!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
