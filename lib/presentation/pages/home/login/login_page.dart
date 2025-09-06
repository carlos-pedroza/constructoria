import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/entities/security_auth.dart';
import 'package:constructoria/domain/repositories/security_queries.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginPage extends StatefulWidget {
  final void Function() onLogin;
  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _passwordVisible = false;
  var _isGetEmailStep = true;
  var _emailToken = '';

  @override
  void initState() {
    super.initState();
    if (!kReleaseMode) {
      _emailController.text = 'julio@tecjamaya.com.mx';
      _passwordController.text = '1234567';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenido',
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Por favor, inicie sesión',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese su email';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Por favor, ingrese un email válido';
                            }
                            return null;
                          },
                          readOnly: !_isGetEmailStep,
                        ),
                        if (!_isGetEmailStep) ...[
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_passwordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese su contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                        ],
                        SizedBox(height: 30),
                        Mutation(
                          options: MutationOptions(
                            document: gql(
                              _isGetEmailStep
                                  ? SecurityQueries.loginEmpleado
                                  : SecurityQueries.loginEmpleadoPassword,
                            ),
                            onCompleted: (data) {
                              if (data == null) return;
                              if (_isGetEmailStep) {
                                final result = data['loginEmpleado'];
                                if (result['result'] == true) {
                                  var token = data['loginEmpleado']['token'];
                                  if (token != null) {
                                    setState(() {
                                      _emailToken = token;
                                      _isGetEmailStep = false;
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'El correo electrónico no es válido.',
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'El correo electrónico no es válido.',
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                final result = data['loginEmpleadoPassword'];
                                if (result['result'] == true) {
                                  var jwt =
                                      data['loginEmpleadoPassword']['jwt'] ??
                                      '';
                                  var empleado =
                                      data['loginEmpleadoPassword']['empleado'];
                                  if (jwt != null && empleado != null) {
                                    SecurityAuth.login(
                                      jwt: jwt,
                                      empleado: Empleado.fromJson(
                                        empleado as Map<String, dynamic>,
                                      ),
                                    ).then((value) {
                                      widget.onLogin();
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Error en el inicio de sesión. Verifique sus credenciales.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error de red. Intente de nuevo.',
                                  ),
                                ),
                              );
                            },
                          ),
                          builder: (runMutation, result) {
                            return ElevatedButton.icon(
                              onPressed: () => _submitForm(runMutation),
                              label: Text(
                                _isGetEmailStep
                                    ? 'Continuar'
                                    : 'Iniciar sesión',
                              ),
                              icon: const Icon(Icons.login),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(runMutation) {
    if (_formKey.currentState!.validate()) {
      if (_isGetEmailStep) {
        runMutation({'correo': _emailController.text});
      } else {
        runMutation({
          'token': _emailToken,
          'password': _passwordController.text,
        });
      }
    }
  }
}
