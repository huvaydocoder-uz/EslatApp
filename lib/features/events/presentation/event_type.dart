import '../../../core/l10n/l10n.dart';
import '../domain/custom_category.dart';
import '../domain/event_category.dart';
import '../domain/important_event.dart';
import 'event_category_ui.dart';

/// Kunning turi: tayyor turlardan biri yoki foydalanuvchining o'z turi.
/// Filtr, forma va tafsilotlarda bir xil ishlatiladi.
class EventType {
  const EventType.builtIn(EventCategory this.category) : custom = null;
  const EventType.custom(CustomCategory this.custom) : category = null;

  final EventCategory? category;
  final CustomCategory? custom;

  String get emoji => custom?.emoji ?? category!.defaultEmoji;

  String label(AppLocalizations l10n) => custom?.name ?? category!.label(l10n);

  /// O'z turi o'chirilgan bo'lsa — "Boshqa" sifatida ko'rinadi.
  static EventType of(ImportantEvent event, List<CustomCategory> customs) {
    final id = event.customCategoryId;
    if (id != null) {
      for (final c in customs) {
        if (c.id == id) return EventType.custom(c);
      }
    }
    return EventType.builtIn(event.category);
  }

  bool matches(ImportantEvent event) => custom != null
      ? event.customCategoryId == custom!.id
      : event.category == category && event.customCategoryId == null;

  @override
  bool operator ==(Object other) =>
      other is EventType &&
      other.category == category &&
      other.custom?.id == custom?.id;

  @override
  int get hashCode => Object.hash(category, custom?.id);
}
