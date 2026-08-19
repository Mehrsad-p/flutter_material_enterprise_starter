import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Reusable page transition animations for GoRouter.
class AppPageTransition {
  const AppPageTransition._();

  /// A clean, standard Fade-Through transition (combines subtle scale/zoom and fade).
  /// Perfect for main destination switches (e.g., Splash/Launcher to Home).
  static Page<T> fadeThrough<T>({
    required Widget child,
    required LocalKey key,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleCurve = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        );
        final scaleTween = Tween<double>(
          begin: 0.96,
          end: 1.0,
        ).animate(scaleCurve);

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: scaleTween, child: child),
        );
      },
    );
  }

  /// A clean and simple Fade transition.
  static Page<T> fade<T>({
    required Widget child,
    required LocalKey key,
    Duration duration = const Duration(milliseconds: 250),
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// A smooth Slide-Up transition with fade.
  /// Ideal for detail pages, sheets, or sub-settings.
  static Page<T> slideUp<T>({
    required Widget child,
    required LocalKey key,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.08); // Subtle slide up (8% height)
        const end = Offset.zero;
        final curve = Curves.fastOutSlowIn;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  /// A smooth horizontal slide transition (slides left for LTR, right for RTL) with fade.
  /// Ideal for push/pop navigation animations between screens.
  static Page<T> slideHorizontal<T>({
    required Widget child,
    required LocalKey key,
    Duration duration = const Duration(milliseconds: 250),
    double slideDistance =
        0.1, // Subtle slide. Set to 1.0 for full screen slide.
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final isRtl = Directionality.of(context) == TextDirection.rtl;

        // If RTL, slide from left (-X) to right. If LTR, slide from right (+X) to left.
        final beginX = isRtl ? -slideDistance : slideDistance;
        final begin = Offset(beginX, 0.0);
        const end = Offset.zero;

        final curve = Curves.fastOutSlowIn;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
