import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;

  const DropDownWidget({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: const InputDecoration(
        filled: false,
        border: OutlineInputBorder(),
      ),
      value: _selectedValue,
      items: widget.items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() => _selectedValue = newValue);
        widget.onChanged?.call(newValue);
      },
      onSaved: widget.onSaved,
    );
  }
}
