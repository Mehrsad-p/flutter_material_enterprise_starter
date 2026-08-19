import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/states/home_state.dart';
import 'package:flutter_material_enterprise_starter/features/home/presentation/widgets/home_card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('میز کار مدیریت'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(homeControllerProvider.notifier).loadDashboard(),
          ),
        ],
      ),
      body: SafeArea(
        child: state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          ),
          error: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: theme.colorScheme.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => ref.read(homeControllerProvider.notifier).loadDashboard(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('تلاش مجدد'),
                ),
              ],
            ),
          ),
          success: (summary) => SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        summary.welcomeMessage,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'وضعیت کنونی سامانه و آمار کلی در این بخش قابل مشاهده است.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'آمار و کارکردها',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                HomeCardWidget(
                  title: 'کاربران فعال سامانه',
                  value: '${summary.activeUsersCount} نفر',
                  icon: Icons.people_alt_rounded,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                HomeCardWidget(
                  title: 'کارهای در انتظار بررسی',
                  value: '${summary.pendingTasksCount} مورد',
                  icon: Icons.task_alt_rounded,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
