import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ۱. دریافت وضعیت تم و زبان
    final themeMode = ref.watch(appThemeNotifierProvider);

    // ۲. دریافت ناتیفایرها برای اعمال تغییرات
    final themeNotifier = ref.read(appThemeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('حالت شب'),
            value: themeMode == ThemeMode.dark,
            onChanged: (_) => themeNotifier.toggleTheme(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
