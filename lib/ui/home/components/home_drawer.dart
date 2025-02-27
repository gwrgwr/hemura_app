import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/ui/auth/auth_viewmodel.dart';
import 'package:hemura/ui/auth/pages/page_view_auth.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({required this.sessionEntity, super.key});

  final SessionEntity sessionEntity;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final authViewModel = AuthViewModel();

  @override
  void initState() {
    authViewModel.logoutUser.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    authViewModel.logoutUser.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.sessionEntity.name,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    text: "Quantidade de Tarefas: ",
                    children: [
                      TextSpan(
                        text: widget.sessionEntity.tasks.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        text: "Código: ",
                        children: [
                          TextSpan(
                            text: widget.sessionEntity.code,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Clipboard.setData(
                          ClipboardData(text: widget.sessionEntity.code),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Copiado para a área de transferência!',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Copiar",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              "Participantes",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListView.builder(
            itemCount: widget.sessionEntity.users.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.sessionEntity.users[index].name),
                subtitle: Text(widget.sessionEntity.users[index].email),
              );
            },
          ),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.all(18),
                  ),
                ),
                onPressed: () {
                  authViewModel.logoutUser.execute();
                },
                child: Text("Sair"),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _listener() {
    if(authViewModel.logoutUser.running) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Saindo..."),
        ),
      );
    }
    if(authViewModel.logoutUser.completed) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageViewAuth()), (route) => false);
    }
  }
}
