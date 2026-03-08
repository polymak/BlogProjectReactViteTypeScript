import 'package:flutter/material.dart';

class UploadField extends StatelessWidget {
  final String? fileName;
  final VoidCallback onUploadTap;
  final VoidCallback onFileSelect;

  const UploadField({
    Key? key,
    this.fileName,
    required this.onUploadTap,
    required this.onFileSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        const Text(
          'Choisir un fichier',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),

        const SizedBox(height: 12),

        // Upload zone
        InkWell(
          onTap: onFileSelect,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
            ),
            child: Column(
              children: [
                // Icon
                const Icon(Icons.upload, size: 32, color: Color(0xFF1976D2)),

                const SizedBox(height: 8),

                // Main text
                Text(
                  fileName ?? 'Télécharger un fichier',
                  style: TextStyle(
                    fontSize: 16,
                    color: fileName != null
                        ? const Color(0xFF333333)
                        : const Color(0xFF1976D2),
                    fontWeight: fileName != null
                        ? FontWeight.normal
                        : FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                // Secondary text
                const Text(
                  'ou glisser-déposer',
                  style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                ),

                const SizedBox(height: 8),

                // Help text
                const Text(
                  'PNG, JPG, GIF jusqu\'à 10MB',
                  style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
