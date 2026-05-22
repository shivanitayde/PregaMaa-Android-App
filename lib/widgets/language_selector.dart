import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLang;
  final Function(String) onChanged;

  const LanguageSelector({
    super.key,
    required this.selectedLang,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedLang,

      items: const [
        DropdownMenuItem(value: "en", child: Text("English")),

        DropdownMenuItem(value: "hi", child: Text("Hindi")),

        DropdownMenuItem(value: "mr", child: Text("Marathi")),
      ],

      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
