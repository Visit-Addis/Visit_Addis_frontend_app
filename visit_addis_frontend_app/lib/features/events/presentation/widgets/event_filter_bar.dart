import 'package:flutter/material.dart';

class EventFilterBar extends StatelessWidget {
  final Function(String?) onCategorySelected;
  final Function(String?) onTimeFilterSelected;

  const EventFilterBar({
    super.key,
    required this.onCategorySelected,
    required this.onTimeFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                onSelected: (selected) => onCategorySelected(selected ? 'All' : null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Music',
                onSelected: (selected) => onCategorySelected(selected ? 'Music' : null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Sports',
                onSelected: (selected) => onCategorySelected(selected ? 'Sports' : null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Art',
                onSelected: (selected) => onCategorySelected(selected ? 'Art' : null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Food',
                onSelected: (selected) => onCategorySelected(selected ? 'Food' : null),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'Today',
                onSelected: (selected) => onTimeFilterSelected(selected ? 'today' : null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'This Week',
                onSelected: (selected) => onTimeFilterSelected(selected ? 'this_week' : null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'This Month',
                onSelected: (selected) => onTimeFilterSelected(selected ? 'this_month' : null),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final Function(bool) onSelected;

  const _FilterChip({
    required this.label,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: onSelected,
    );
  }
} 