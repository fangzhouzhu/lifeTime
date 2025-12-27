import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 设置页面
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _version = '加载中...';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = '${packageInfo.version}+${packageInfo.buildNumber}';
      });
    } catch (e) {
      setState(() {
        _version = '1.0.0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置'), elevation: 0),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection(
              title: '通知设置',
              children: [
                SwitchListTile(
                  title: const Text('开启通知'),
                  subtitle: const Text('在纪念日当天提醒我'),
                  value: true,
                  onChanged: (value) {
                    // TODO: 实现通知设置
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('通知功能开发中')));
                  },
                  secondary: const Icon(Icons.notifications),
                ),
                ListTile(
                  leading: const Icon(Icons.schedule),
                  title: const Text('提醒时间'),
                  subtitle: const Text('上午 9:00'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: 选择提醒时间
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('时间选择功能开发中')));
                  },
                ),
              ],
            ),
            _buildSection(
              title: '数据管理',
              children: [
                ListTile(
                  leading: const Icon(Icons.backup),
                  title: const Text('备份数据'),
                  subtitle: const Text('导出所有纪念日数据'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: 实现数据备份
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('备份功能开发中')));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text('恢复数据'),
                  subtitle: const Text('从备份文件恢复'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: 实现数据恢复
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('恢复功能开发中')));
                  },
                ),
              ],
            ),
            _buildSection(
              title: '外观设置',
              children: [
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text('主题颜色'),
                  subtitle: const Text('自定义应用主题'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: 主题设置
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('主题设置功能开发中')));
                  },
                ),
                SwitchListTile(
                  title: const Text('深色模式'),
                  subtitle: const Text('使用深色主题'),
                  value: false,
                  onChanged: (value) {
                    // TODO: 切换深色模式
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('深色模式开发中')));
                  },
                  secondary: const Icon(Icons.dark_mode),
                ),
              ],
            ),
            _buildSection(
              title: '关于',
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('版本信息'),
                  subtitle: Text(_version),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('使用帮助'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showHelp();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('给个好评'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('感谢您的支持！')));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shadowColor: Theme.of(context).primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('使用帮助'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('如何添加纪念日？', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('点击右下角的"+"按钮，填写纪念日信息即可。'),
              SizedBox(height: 16),
              Text('如何添加图片或视频？', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('在添加/编辑纪念日时，点击"选择图片"或"选择视频"按钮。'),
              SizedBox(height: 16),
              Text('如何查看详情？', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('点击任意纪念日卡片即可查看详细信息。'),
              SizedBox(height: 16),
              Text('如何编辑或删除？', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('在详情页面，点击右下角的编辑按钮可以修改，点击顶部的删除按钮可以删除。'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }
}
