import 'package:flutter/material.dart';
import 'package:mealbook/common/ui/app_colors.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    required T value,
    required T groupValue,
    required ValueChanged<T> onChanged,
    required String leading,
    Key? key,
  })  : _value = value,
        _leading = leading,
        _onChanged = onChanged,
        _isSelected = value == groupValue,
        super(key: key);

  final T _value;
  final String _leading;
  final ValueChanged<T> _onChanged;
  final bool _isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? AppColors.accent : AppColors.primary,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _onChanged(_value),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: SizedBox(
            height: 64,
            child: Center(
              child: Text(
                _leading,
                style: TextStyle(
                  color: _isSelected ? AppColors.primary : AppColors.textFaded,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
