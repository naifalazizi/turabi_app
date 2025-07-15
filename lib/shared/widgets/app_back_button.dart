import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final bool showText;
  final String? text;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.size,
    this.showText = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();
    
    if (!canPop) {
      return const SizedBox.shrink();
    }

    if (showText) {
      return TextButton.icon(
        onPressed: onPressed ?? () => context.pop(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: color ?? AppColors.textPrimary,
          size: size ?? 18,
        ),
        label: Text(
          text ?? 'رجوع',
          style: TextStyle(
            color: color ?? AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
      );
    }

    return IconButton(
      onPressed: onPressed ?? () => context.pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: color ?? AppColors.textPrimary,
        size: size ?? 24,
      ),
    );
  }
}

class AppFloatingBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const AppFloatingBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();
    
    if (!canPop) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onPressed ?? () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: iconColor ?? AppColors.textPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class AppNavigationBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;

  const AppNavigationBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showBackButton && canPop)
            AppBackButton(
              onPressed: onBackPressed,
            ),
          if (title != null) ...[
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ] else
            const Spacer(),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

// Extension لإضافة دعم أفضل للتنقل
extension AppNavigationExtension on BuildContext {
  bool get canGoBack => GoRouter.of(this).canPop();
  
  void goBack() {
    if (canGoBack) {
      pop();
    }
  }
  
  void goBackOr(String route) {
    if (canGoBack) {
      pop();
    } else {
      go(route);
    }
  }
}
