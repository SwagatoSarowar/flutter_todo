import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/models/filter.dart';

class FilterItem extends StatelessWidget {
  const FilterItem(this.filter, this.onFilterChange, {super.key});

  final Filter filter;
  final void Function(String) onFilterChange;

  @override
  Widget build(BuildContext context) {
    bool isActive = filter.isSelected;

    return ChoiceChip(
      label: Text(filter.label),
      labelStyle: TextStyle(
        color: isActive ? Colors.white : AppColors.primaryColor,
        fontWeight: FontWeight(isActive ? 900 : 500),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
      selected: isActive,
      showCheckmark: false,
      selectedColor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryLight,

      onSelected: (bool selected) {
        onFilterChange(filter.label);
      },
    );
  }
}
