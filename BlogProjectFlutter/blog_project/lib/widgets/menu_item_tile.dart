import 'package:flutter/material.dart';

class MenuItemTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItemTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF333333), size: 20),
              ),

              const SizedBox(width: 16),

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),

              const Spacer(),

              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: const Color(0xFF999999),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
