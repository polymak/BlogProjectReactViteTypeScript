import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const UsernameField({
    Key? key,
    required this.controller,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        const Text(
          'Nom d\'utilisateur',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),

        const SizedBox(height: 8),

        // Input field
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.person,
              color: Color(0xFF999999),
              size: 20,
            ),
            hintText: 'votre_pseudo',
            hintStyle: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
          cursorColor: const Color(0xFF1976D2),
        ),

        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      ],
    );
  }
}
