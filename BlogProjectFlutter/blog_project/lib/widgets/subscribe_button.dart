import 'package:flutter/material.dart';

class SubscribeButton extends StatelessWidget {
  final VoidCallback onTap;

  const SubscribeButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Material(
        color: const Color(0xFF1976D2),
        borderRadius: BorderRadius.circular(28),
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Center(
              child: Text(
                'S’abonner',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
