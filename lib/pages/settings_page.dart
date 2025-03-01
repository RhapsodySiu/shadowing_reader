import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowing_reader/notifiers/theme_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
              leading: const Icon(Icons.palette),
              title: Text(
                'Theme color',
                style: textStyle,
              ),
              trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    showTheemeColorDialog(context);
                  })),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text('Dark Mode', style: textStyle),
            trailing: Consumer<ThemeNotifier>(
              builder: (context, themeNotifier, child) {
                return Switch(
                  value: themeNotifier.isDarkMode,
                  onChanged: (value) {
                    themeNotifier.toggleTheme();
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Font Size'),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // TODO: Implement font size settings
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TODO: Implement notifications toggle
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // TODO: Show about dialog
            },
          ),
        ],
      ),
    );
  }

  Widget buildThemeColorOption(
      BuildContext context, String title, Color color) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Provider.of<ThemeNotifier>(context, listen: false)
            .updateSeedColor(color);
        Navigator.of(context).pop();
      },
    );
  }

  void showTheemeColorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Theme Color'),
            content: Column(
              children: [
                buildThemeColorOption(
                    context, 'Purple Theme', Colors.deepPurple),
                buildThemeColorOption(context, 'Green Theme', Colors.green),
                buildThemeColorOption(context, 'Blue Theme', Colors.blue),
                buildThemeColorOption(context, 'Red Theme', Colors.red),
              ],
            ),
          );
        });
  }
}
