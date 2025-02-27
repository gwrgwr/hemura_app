import 'package:flutter/material.dart';
import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/data/repositories/auth_repository.dart';
import 'package:hemura/ui/auth/auth_viewmodel.dart';
import 'package:hemura/ui/auth/components/google_button.dart';
import 'package:hemura/ui/auth/components/my_custom_painter.dart';
import 'package:hemura/ui/auth/components/my_textformfield.dart';
import 'package:hemura/ui/home/components/home_page.dart';
import 'package:hemura/ui/session/pages/session_page.dart';
import 'package:hemura/utils/components/splash_screen.dart';
import 'package:hemura/utils/enums/text_field_type.dart';

class Loginpage extends StatefulWidget {
  Loginpage({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var userService = ApiClient();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController senhaTextEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _authViewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
    _authViewModel.loginUser.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    _authViewModel.loginUser.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusScope.of(context).unfocus()},
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ListenableBuilder(
          listenable: _authViewModel.loginUser,
          builder: (context, child) {
            if (_authViewModel.loginUser.running) {
              return SplashScreen();
            }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MyCustomPainter(),
                    Container(
                      padding: EdgeInsets.only(top: 200),
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              MyTextformfield(
                                label: "Email",
                                editingController: emailTextEditingController,
                                type: TextFieldType.email,
                              ),
                              MyTextformfield(
                                label: "Senha",
                                editingController: senhaTextEditingController,
                                type: TextFieldType.password,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FilledButton(
                                  onPressed:
                                      () => {
                                    if (_formKey.currentState!.validate()) {
                                      _authViewModel.loginUser.execute((emailTextEditingController.text, senhaTextEditingController.text)),
                                    },
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text("Enviar"),
                                  ),
                                ),
                              ),
                              GoogleButton(
                                function: () => {},
                                text: "Entre com sua conta Google",
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Não tem uma conta?"),
                                  TextButton(
                                    onPressed:
                                        () => {
                                      widget.pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      ),
                                    },
                                    child: Text("Registrar"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
        ),
      ),
    );

  }

  void _listener() {
    if (_authViewModel.loginUser.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao fazer login"),
        ),
      );
    }
    if (_authViewModel.userEntity != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SessionPage(),
        ),
      );
    }
  }
}
