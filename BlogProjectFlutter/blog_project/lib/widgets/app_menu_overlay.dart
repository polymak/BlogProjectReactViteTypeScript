import 'package:flutter/material.dart';
import 'package:blog_project/widgets/menu_header.dart';
import 'package:blog_project/widgets/menu_item_tile.dart';
import 'package:blog_project/widgets/subscribe_button.dart';

class AppMenuOverlay extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onLoginTap;
  final VoidCallback onSubscribeTap;
  final VoidCallback onClose;

  const AppMenuOverlay({
    Key? key,
    required this.onHomeTap,
    required this.onLoginTap,
    required this.onSubscribeTap,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background overlay
          GestureDetector(
            onTap: onClose,
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          // Menu panel
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Menu header
                  MenuHeader(onClose: onClose),

                  // Menu items separator
                  Container(
                    height: 1,
                    color: const Color(0xFFE0E0E0),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),

                  // Menu items
                  Expanded(
                    child: Column(
                      children: [
                        MenuItemTile(
                          title: 'Accueil',
                          icon: Icons.home,
                          onTap: () {
                            onClose();
                            onHomeTap();
                          },
                        ),

                        Container(
                          height: 1,
                          color: const Color(0xFFE0E0E0),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),

                        MenuItemTile(
                          title: 'Login',
                          icon: Icons.login,
                          onTap: () {
                            onClose();
                            onLoginTap();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
