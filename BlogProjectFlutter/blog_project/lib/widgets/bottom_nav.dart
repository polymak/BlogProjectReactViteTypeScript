import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({Key? key, required this.currentIndex, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: const Color(0xFF1976D2),
      unselectedItemColor: const Color(0xFF999999),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_outlined),
          activeIcon: Icon(Icons.newspaper),
          label: 'Actualités',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Favoris',
        ),
      ],
    );
  }
}
