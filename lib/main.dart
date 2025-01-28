import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_it_edition/controller.dart';
import 'package:wordle_it_edition/themes/switch.dart';
import 'package:wordle_it_edition/themes/theme.dart';
import 'package:wordle_it_edition/themes/theme_preference.dart';
import 'pages/gamepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => ThemeSwitch()),
    ],
    child: FutureBuilder(
      initialData: false,
      future: ThemePreferences.getTheme(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance?.addPostFrameCallback((timestamp){
          Provider.of<ThemeSwitch>(context, listen: false).setTheme(turnOn: 
          snapshot.data as bool
          );
          });
        }
        return Consumer<ThemeSwitch>(
        builder: (_, notifier, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Worlde IT Edition',
          theme: notifier.isDark ? darkTheme : lightTheme,
          home: const Material (child: HomePage()),
        ),
        );
        }),
    );
  }
}
