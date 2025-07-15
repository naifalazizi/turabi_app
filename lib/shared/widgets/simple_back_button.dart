import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class SimpleBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SimpleBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.textPrimary,
        size: 24,
      ),
      onPressed: onPressed ?? () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else if (GoRouter.of(context).canPop()) {
          context.pop();
        }
      },
    );
  }
}
