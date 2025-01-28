import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_it_edition/notice.dart';
import 'package:wordle_it_edition/themes/switch.dart';
import 'package:wordle_it_edition/themes/theme_preference.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeSwitch>(
            builder: (_, notifier, __) {
              bool _isSwitched = false;
              _isSwitched = notifier.isDark;

              return SwitchListTile(
                title: const Text('Dark mode'), value: _isSwitched,
                onChanged: (value) {
                  _isSwitched = value;
                  ThemePreferences.saveTheme(isDark: _isSwitched);
                  Provider.of<ThemeSwitch>(context, listen: false)
                      .setTheme(turnOn: _isSwitched);
                },
              );
            },
          ),
          ListTile(
            title: const Text('Reset Statistics'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('stats');
              prefs.remove('chart');
              prefs.remove('row');
              runQuickBox(context: context, message: 'Statistics Reset');
            },
          ),
        ],
      ),
    );
  }
}