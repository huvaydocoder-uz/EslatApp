import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// Ilovadagi yagona matn maydoni: katta shrift, yorliq, xato matni.
///
/// O'z `TextEditingController`ini o'zi boshqaradi (faqat ekran ichidagi
/// vaqtinchalik holat); qiymat har o'zgarganda [onChanged] orqali
/// Riverpod controllerga uzatiladi.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.label,
    this.hint,
    this.errorText,
    this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
    this.suffix,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final String label;
  final String? hint;
  final String? errorText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  /// Maydon oxiridagi tugma (masalan, "Kontaktlardan tanlash").
  final Widget? suffix;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final _controller = TextEditingController(text: widget.initialValue);

  /// Qiymat tashqaridan o'zgarsa (masalan, kontakt tanlandi) — maydon ham yangilanadi.
  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        errorText: widget.errorText,
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        suffixIcon: widget.suffix,
        counterText: '',
      ),
    );
  }
}
