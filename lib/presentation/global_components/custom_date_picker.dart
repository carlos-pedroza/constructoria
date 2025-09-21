import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.label,
    required this.initialDate,
    required this.onChanged,
  });

  final String label;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onChanged;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDateTime;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Default initial date: now
    _selectedDateTime = widget.initialDate ?? DateTime.now();
    _controller = TextEditingController(text: _formatDate(_selectedDateTime));
  }

  @override
  void didUpdateWidget(covariant CustomDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != null && widget.initialDate != oldWidget.initialDate) {
      _selectedDateTime = widget.initialDate!;
      _controller.text = _formatDate(_selectedDateTime);
    }
  }

  String _formatDate(DateTime dt) {
    return "${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
           "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDateTime = DateTime(
          picked.year, picked.month, picked.day,
          _selectedDateTime.hour, _selectedDateTime.minute,
        );
        _controller.text = _formatDate(_selectedDateTime);
      });
      if (widget.onChanged != null) widget.onChanged!(_selectedDateTime);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _selectedDateTime.hour, minute: _selectedDateTime.minute),
    );
    if (picked != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day,
          picked.hour, picked.minute,
        );
        _controller.text = _formatDate(_selectedDateTime);
      });
      if (widget.onChanged != null) widget.onChanged!(_selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              readOnly: true,
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                hintText: widget.label,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerLowest,
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              onTap: _pickDate,
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.grey[600], size: 18),
            onPressed: _pickDate,
            tooltip: 'Cambiar fecha',
          ),
          IconButton(
            icon: Icon(Icons.access_time, color: Colors.grey[600], size: 18),
            onPressed: _pickTime,
            tooltip: 'Cambiar hora',
          ),
        ],
      ),
    );
  }
}

