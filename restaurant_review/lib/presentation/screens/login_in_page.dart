import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_events.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_state.dart';
import 'package:restaurant_review/infrastructure/repository/auth_repository.dart';
import 'package:restaurant_review/domain/usecase/auth_usecase.dart';

class LogInPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();
    final logInUseCase = AuthUseCase(authRepository: authRepository);

    return BlocProvider(
      create: (context) => AuthBloc(authUseCase: logInUseCase),
      child: LogInForm(),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.user.roles[0] == 'admin') {
              context.go('/adminprofile');
            } else {
              context.go('/home');
            }
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                AuthField(
                  hintText: "Username",
                  controller: usernameController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: "Password",
                  controller: passwordController,
                  isObscure: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    }
                    return AuthGradientButton(
                      buttonText: "Sign In",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            LogInButtonPressed(
                              username: usernameController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.go('/signup');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: ' Sign Up',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient3,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
