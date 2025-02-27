import 'package:flutter/material.dart';
import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/ui/home/components/home_page.dart';
import 'package:hemura/ui/home/pages/home_screen.dart';
import 'package:hemura/ui/session/components/create_session_component.dart';
import 'package:hemura/ui/session/session_viewmodel.dart';
import 'package:hemura/utils/components/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final _sessionViewModel = SessionViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _sessionViewModel.get,
      builder: (context, child) {
        if (_sessionViewModel.get.error) {
          return CreateSessionComponent();
        }
        if (_sessionViewModel.get.running) {
          return SplashScreen();
        }
        return HomeScreen(
          sessionEntity: _sessionViewModel.sessionEntity as SessionEntity,
        );
      },
    );
  }
}

void _listener() {

}