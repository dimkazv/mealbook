import 'package:flutter/material.dart';
import 'package:template_bloc/common/ui/app_colors.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    Key? key,
  }) : super(key: key);

  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: SizedBox(
        height: 64,
        child: _customRadioButton,
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accent : AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          leading,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textFaded,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
