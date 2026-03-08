import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final VoidCallback onToggleObscureText;

  const PasswordField({
    Key? key,
    required this.controller,
    this.errorText,
    this.onChanged,
    required this.obscureText,
    required this.onToggleObscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with forgot link
        Row(
          children: [
            const Text(
              'Mot de passe',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),

            const Spacer(),

            // Forgot password link
            TextButton(
              onPressed: () {
                // Visual only - no backend functionality
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Oublié ?',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Input field
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock,
              color: Color(0xFF999999),
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF999999),
                size: 20,
              ),
              onPressed: onToggleObscureText,
            ),
            hintText: '••••••••',
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
