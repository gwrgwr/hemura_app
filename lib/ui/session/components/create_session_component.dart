import 'package:flutter/material.dart';
import 'package:hemura/ui/home/components/home_page.dart';
import 'package:hemura/ui/home/pages/home_screen.dart';
import 'package:hemura/ui/session/session_viewmodel.dart';

class CreateSessionComponent extends StatefulWidget {
  const CreateSessionComponent({super.key});

  @override
  State<CreateSessionComponent> createState() => _CreateSessionComponentState();
}

class _CreateSessionComponentState extends State<CreateSessionComponent> {
  final TextEditingController sessionNameEditingController =
      TextEditingController();
  final TextEditingController sessionCodeEditingController =
      TextEditingController();

  final _sessionController = SessionViewModel();

  @override
  void initState() {
    super.initState();
    _sessionController.addSession.addListener(_listener);
    _sessionController.joinSession.addListener(_joinListener);
  }

  @override
  void dispose() {
    super.dispose();
    _sessionController.addSession.removeListener(_listener);
    _sessionController.joinSession.removeListener(_joinListener);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _sessionController.addSession,
      builder: (context, child) {
        if (_sessionController.addSession.running) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: Center(
            child: Column(
              spacing: 40,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nenhuma sessão encontrada",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Criar uma sessão",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: sessionNameEditingController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Nome da sessão",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "createSession",
                      onPressed: () {
                        _sessionController.addSession.execute(
                          sessionNameEditingController.text,
                        );
                      },
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
                Text("Ou", style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  "Entrar em uma sessão",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: sessionCodeEditingController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Código da sessão",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "joinSession",
                      onPressed: () {
                        _sessionController.joinSession.execute(
                          sessionCodeEditingController.text,
                        );
                      },
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_right_outlined, size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _listener() {
    if (_sessionController.addSession.error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao criar sessão")));
    }
    if (_sessionController.sessionEntity != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  HomeScreen(sessionEntity: _sessionController.sessionEntity!),
        ),
      );
    }
  }

  void _joinListener() {
    if (_sessionController.joinSession.error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao entrar na sessão")));
    }
    if (_sessionController.sessionEntity != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  HomeScreen(sessionEntity: _sessionController.sessionEntity!),
        ),
      );
    }
  }
}
