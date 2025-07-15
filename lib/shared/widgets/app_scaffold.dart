import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/constants/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showAppBar;
  final bool showBackButton;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final Widget? drawer;
  final Widget? endDrawer;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBackPressed;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.actions,
    this.leading,
    this.showAppBar = true,
    this.showBackButton = true,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.drawer,
    this.endDrawer,
    this.bottom,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final goCanPop = GoRouter.of(context).canPop();
    debugPrint('AppScaffold: Navigator.canPop=$canPop, GoRouter.canPop=$goCanPop, showBackButton=$showBackButton');
    
    // Determine the leading widget
    Widget? appBarLeading;
    if (leading != null) {
      appBarLeading = leading;
    } else if (showBackButton) {
      // Always show back button if showBackButton is true, regardless of navigation stack
      appBarLeading = IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 24,
        ),
        onPressed: onBackPressed ?? () {
          debugPrint('Back button pressed: Navigator.canPop=$canPop, GoRouter.canPop=$goCanPop');
          try {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              // Fallback: navigate to home or user type based on current route
              final currentRoute = GoRouterState.of(context).uri.toString();
              if (currentRoute.contains('/login') || currentRoute.contains('/register')) {
                context.go('/user-type');
              } else {
                context.go('/home');
              }
            }
          } catch (e) {
            debugPrint('Error in back navigation: $e');
            // Fallback navigation
            context.go('/home');
          }
        },
      );
    }
    
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      endDrawer: endDrawer,
      appBar: showAppBar
          ? AppBar(
              title: title != null ? Text(title!) : null,
              actions: actions,
              leading: appBarLeading,
              automaticallyImplyLeading: false,
              bottom: bottom,
            )
          : null,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: ResponsiveHelper.responsivePadding(context),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? ResponsiveHelper.responsivePadding(context),
      margin: margin ?? ResponsiveHelper.responsiveMargin(context),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: border,
      ),
      child: child,
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppContainer(
        padding: padding,
        margin: margin,
        child: child,
      ),
    );
  }
}
