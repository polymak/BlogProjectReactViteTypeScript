import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final VoidCallback onBackTap;

  const LoginHeader({Key? key, required this.onBackTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.newspaper,
              color: Color(0xFF1976D2),
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          // Title
          Text(
            'Mon Blog',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const Spacer(),

          // Back link
          TextButton(
            onPressed: onBackTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Retour au site',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
