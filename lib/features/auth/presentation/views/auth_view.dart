import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/app/router/app_routes.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/states/auth_state.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/views/login_view.dart';
import 'package:flutter_material_enterprise_starter/features/auth/presentation/views/register_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    setState(() => _currentPage = page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      next.maybeWhen(
        success: (user) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خوش آمدید، ${user.email}'),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRoutes.home);
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPage == 0 ? 'ورود' : 'ثبت‌نام'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginView(onSwitchToRegister: () => _navigateToPage(1)),
          RegisterView(onSwitchToLogin: () => _navigateToPage(0)),
        ],
      ),
    );
  }
}
