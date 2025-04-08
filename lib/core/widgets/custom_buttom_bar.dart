import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhood/constants.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final bool isFabMenuOpen;
  final VoidCallback onSellTapped;
  final VoidCallback onChangeTapped;
  final VoidCallback onSellConsoleTapped;
  final AnimationController fabController;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isFabMenuOpen,
    required this.onSellTapped,
    required this.onChangeTapped,
    required this.onSellConsoleTapped,
    required this.fabController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarItem(
                index: 0,
                icon: Icons.eco_outlined,
                activeIcon: Icons.eco,
                label: 'My Plants',
                isSelected: selectedIndex == 0,
                onTap: onItemTapped,
              ),
              BottomBarItem(
                index: 1,
                icon: Icons.shopping_basket_outlined,
                activeIcon: Icons.shopping_basket,
                label: 'Shop',
                isSelected: selectedIndex == 1,
                onTap: onItemTapped,
              ),

              // Center FAB placeholder
              BottomBarItem(
                index: 3,
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today,
                label: 'Planner',
                isSelected: selectedIndex == 3,
                onTap: onItemTapped,
              ),
              BottomBarItem(
                index: 4,
                icon: Icons.comment_outlined,
                activeIcon: Icons.comment,
                label: 'Community',
                isSelected: selectedIndex == 4,
                onTap: onItemTapped,
              ),
            ],
          ),
        ),
        // Floating Action Button

        // FAB Menu Items (only visible when menu is open)
      ],
    );
  }

  Widget _buildFabMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Constants.primaryColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Constants.textPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final Function(int) onTap;

  const BottomBarItem({
    super.key,
    required this.index,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration:
            isSelected
                ? BoxDecoration(
                  color: Constants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                )
                : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color:
                  isSelected
                      ? Constants.primaryColor
                      : Constants.textSecondaryColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color:
                    isSelected
                        ? Constants.primaryColor
                        : Constants.textSecondaryColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
