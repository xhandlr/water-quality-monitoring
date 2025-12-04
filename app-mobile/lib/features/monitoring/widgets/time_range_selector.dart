import 'package:flutter/material.dart';

enum TimeRange {
  day24h('Últimas 24 horas'),
  days7('Últimos 7 días'),
  days30('Últimos 30 días');

  final String label;
  const TimeRange(this.label);
}

class TimeRangeSelector extends StatelessWidget {
  final TimeRange selectedRange;
  final ValueChanged<TimeRange> onRangeSelected;

  const TimeRangeSelector({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: TimeRange.values.map((range) {
          final isSelected = range == selectedRange;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Center(
                  child: Text(
                    range.label,
                    style: const TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) => onRangeSelected(range),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
