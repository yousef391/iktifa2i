import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenhood/constants.dart';

class CustomFab extends StatelessWidget {
  final VoidCallback onTap;
  final AnimationController fabController;

  const CustomFab({
    super.key,
    required this.onTap,
    required this.fabController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: fabController,
        builder: (context, child) {
          return Transform.rotate(
            angle: fabController.value * 0.75,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                border: Border.all(width: 3, color: Constants.primaryColor),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          );
        },
      ),
    );
  }
}
