import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anniversary.dart';
import '../providers/anniversary_provider.dart';
import '../utils/date_formatter.dart';
import '../theme/app_theme.dart';

/// 添加/编辑纪念日页面
class AddAnniversaryPage extends StatefulWidget {
  final Anniversary? anniversary;

  const AddAnniversaryPage({super.key, this.anniversary});

  @override
  State<AddAnniversaryPage> createState() => _AddAnniversaryPageState();
}

class _AddAnniversaryPageState extends State<AddAnniversaryPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '其他';
  bool _isLunar = false;
  bool _reminder = true;

  final List<String> _categories = ['生日', '恋爱', '结婚', '工作', '纪念', '节日', '其他'];

  @override
  void initState() {
    super.initState();
    if (widget.anniversary != null) {
      _titleController.text = widget.anniversary!.title;
      _descriptionController.text = widget.anniversary!.description ?? '';
      _selectedDate = widget.anniversary!.date;
      _selectedCategory = widget.anniversary!.category;
      _isLunar = widget.anniversary!.isLunar;
      _reminder = widget.anniversary!.reminder;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.anniversary != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? '编辑纪念日' : '添加纪念日'),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteAnniversary,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTitleField(),
            const SizedBox(height: 16),
            _buildDatePicker(),
            const SizedBox(height: 16),
            _buildCategorySelector(),
            const SizedBox(height: 16),
            _buildDescriptionField(),
            const SizedBox(height: 16),
            _buildSwitches(),
            const SizedBox(height: 32),
            _buildSaveButton(isEditing),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: '标题',
        hintText: '输入纪念日标题',
        prefixIcon: Icon(Icons.title),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入标题';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDate,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: '日期',
          prefixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          DateFormatter.formatChineseDate(_selectedDate),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            '分类',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((category) {
            final isSelected = category == _selectedCategory;
            final color = AppTheme.getCategoryColor(category);
            
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppTheme.getCategoryIcon(category),
                    size: 18,
                    color: isSelected ? Colors.white : color,
                  ),
                  const SizedBox(width: 4),
                  Text(category),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
              selectedColor: color,
              backgroundColor: color.withOpacity(0.1),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: '描述（可选）',
        hintText: '添加一些备注或描述',
        prefixIcon: Icon(Icons.notes),
      ),
      maxLines: 3,
    );
  }

  Widget _buildSwitches() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('农历日期'),
          subtitle: const Text('使用农历计算纪念日'),
          value: _isLunar,
          onChanged: (value) {
            setState(() {
              _isLunar = value;
            });
          },
          secondary: const Icon(Icons.calendar_month),
        ),
        SwitchListTile(
          title: const Text('提醒'),
          subtitle: const Text('在纪念日当天提醒我'),
          value: _reminder,
          onChanged: (value) {
            setState(() {
              _reminder = value;
            });
          },
          secondary: const Icon(Icons.notifications),
        ),
      ],
    );
  }

  Widget _buildSaveButton(bool isEditing) {
    return ElevatedButton(
      onPressed: _saveAnniversary,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        isEditing ? '保存修改' : '添加纪念日',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveAnniversary() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<AnniversaryProvider>();
    
    final anniversary = Anniversary(
      id: widget.anniversary?.id,
      title: _titleController.text,
      date: _selectedDate,
      description: _descriptionController.text.isEmpty 
          ? null 
          : _descriptionController.text,
      category: _selectedCategory,
      isLunar: _isLunar,
      reminder: _reminder,
    );

    try {
      if (widget.anniversary == null) {
        await provider.addAnniversary(anniversary);
      } else {
        await provider.updateAnniversary(anniversary);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.anniversary == null ? '添加成功' : '更新成功'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('操作失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteAnniversary() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这个纪念日吗？此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.anniversary != null) {
      try {
        await context.read<AnniversaryProvider>()
            .deleteAnniversary(widget.anniversary!.id!);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('删除成功'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('删除失败: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
