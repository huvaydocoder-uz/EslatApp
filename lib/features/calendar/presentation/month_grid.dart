import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/l10n/l10n.dart';
import '../../events/domain/event_occurrence.dart';
import '../../events/domain/important_event.dart';
import '../../events/presentation/calendar_controller.dart';

/// Oy jadvali: hafta kunlari telefon tiliga mos (dushanba/yakshanbadan),
/// muhim kunlar emoji bilan, bugun — hoshiya, tanlangan — rang bilan.
class MonthGrid extends ConsumerWidget {
  const MonthGrid({
    super.key,
    required this.month,
    required this.today,
    required this.selectedDay,
    required this.eventsByDay,
  });

  final DateTime month;
  final DateTime today;
  final DateTime selectedDay;
  final Map<int, List<ImportantEvent>> eventsByDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = MaterialLocalizations.of(context);
    final l10n = context.l10n;
    final calendar = ref.read(calendarControllerProvider.notifier);
    final firstWeekday = loc.firstDayOfWeekIndex; // 0 = yakshanba
    final leading =
        (DateTime(month.year, month.month).weekday % 7 - firstWeekday) % 7;
    final days = EventDates.daysInMonth(month.year, month.month);
    final weekdays = [
      for (var i = 0; i < 7; i++) loc.narrowWeekdays[(firstWeekday + i) % 7],
    ];

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              tooltip: l10n.calendarPrevMonth,
              icon: const Icon(Icons.chevron_left_rounded, size: 32),
              onPressed: calendar.previousMonth,
            ),
            Expanded(
              child: Text(
                loc.formatMonthYear(month),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: l10n.calendarNextMonth,
              icon: const Icon(Icons.chevron_right_rounded, size: 32),
              onPressed: calendar.nextMonth,
            ),
          ],
        ),
        Row(
          children: [
            for (final name in weekdays)
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.82,
          children: [
            for (var i = 0; i < leading; i++) const SizedBox.shrink(),
            for (var day = 1; day <= days; day++)
              _DayCell(
                date: DateTime(month.year, month.month, day),
                isToday: DateUtils.isSameDay(
                  today,
                  DateTime(month.year, month.month, day),
                ),
                isSelected: DateUtils.isSameDay(
                  selectedDay,
                  DateTime(month.year, month.month, day),
                ),
                events: eventsByDay[day] ?? const [],
                onTap: calendar.select,
              ),
          ],
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.isToday,
    required this.isSelected,
    required this.events,
    required this.onTap,
  });

  final DateTime date;
  final bool isToday;
  final bool isSelected;
  final List<ImportantEvent> events;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final loc = MaterialLocalizations.of(context);
    return Semantics(
      button: true,
      selected: isSelected,
      label: [
        loc.formatFullDate(date),
        ...events.map((e) => e.title),
      ].join(', '),
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onTap(date),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected ? scheme.primary : null,
            borderRadius: BorderRadius.circular(14),
            border: isToday && !isSelected
                ? Border.all(color: scheme.primary, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${date.day}',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: isSelected ? scheme.onPrimary : null),
              ),
              SizedBox(
                height: 20,
                child: events.isEmpty
                    ? null
                    : Text(
                        events.first.emoji,
                        style: const TextStyle(fontSize: 15),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
