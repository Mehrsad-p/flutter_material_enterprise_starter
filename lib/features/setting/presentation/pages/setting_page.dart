import 'package:flutter/material.dart';
import 'package:flutter_material_enterprise_starter/core/design_system/theme/provider/theme_provider.dart';
import 'package:flutter_material_enterprise_starter/features/setting/presentation/widgets/color_picker_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeNotifierProvider);

    final themeNotifier = ref.read(appThemeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text('حالت روشن'),
            value: themeMode.themeMode == ThemeMode.light,
            onChanged: (_) => themeNotifier.toggleTheme(),
          ),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: ColorPickerWidget(),
          ),
        ],
      ),
    );
  }
}
