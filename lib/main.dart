import 'package:flutter/material.dart';
import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/ui/auth/pages/page_view_auth.dart';
import 'package:hemura/ui/auth/user_provider.dart';
import 'package:hemura/ui/home/components/home_page.dart';
import 'package:hemura/ui/session/pages/session_page.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(MyApp(theme: theme, prefs: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final SharedPreferences prefs;

  const MyApp({super.key, required this.theme, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ],
      child: MaterialApp(
        home: prefs.getBool("isLogged") == true ? SessionPage() : PageViewAuth(),
        theme: theme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
