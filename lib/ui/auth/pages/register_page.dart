import 'package:flutter/material.dart';
import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/ui/auth/components/google_button.dart';
import 'package:hemura/ui/auth/components/my_textformfield.dart';
import 'package:hemura/utils/enums/text_field_type.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({required this.pageController, super.key});

  final PageController pageController;

  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController senhaTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final userServices = ApiClient();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusScope.of(context).unfocus()},
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 100),
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
                      "Cadastro",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    MyTextformfield(
                      label: "Nome",
                      editingController: nameTextEditingController,
                      type: TextFieldType.text,
                    ),
                    MyTextformfield(
                      label: "Sobrenome",
                      editingController: lastNameTextEditingController,
                      type: TextFieldType.text,
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
                              if (_formKey.currentState?.validate() != null)
                                {
                                  userServices.register(
                                    nameTextEditingController.text,
                                    lastNameTextEditingController.text,
                                    emailTextEditingController.text,
                                    senhaTextEditingController.text,
                                  ),
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
                      text: "Registre-se com sua conta Google",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Já tem uma conta?"),
                        TextButton(
                          onPressed:
                              () => {
                                pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                ),
                              },
                          child: Text("Entrar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
