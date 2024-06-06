import 'package:flutter/material.dart';
import 'package:flutter_contest/src/common/theme/app_theme_data.dart';
import 'package:flutter_contest/src/feature/mood_journal/widget/mood_journal_screen.dart';

final _a = WidgetStateProperty.resolveWith((states) {
  if (states.contains(WidgetState.disabled)) {
    return TextStyle(fontSize: 20);
  }
  return const TextStyle(fontSize: 20);
});

class App extends StatelessWidget {
  const App({super.key});

  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.theme,
      home: const MoodJournalScreen(),
      builder: (context, child) => SizedBox(
        key: _globalKey,
        child: child,
      ),
    );
  }
}
