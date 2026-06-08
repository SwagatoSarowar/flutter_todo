import 'package:flutter/material.dart';
import 'package:todo_app/models/filter.dart';
import 'package:todo_app/widgets/filters/filter_item.dart';

class Filters extends StatelessWidget {
  const Filters(this.filters, this.onFilterChange, {super.key});

  final List<Filter> filters;
  final void Function(String) onFilterChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            FilterItem(filters[index], onFilterChange),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: filters.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
