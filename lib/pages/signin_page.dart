import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synew_gym/blocs/signin/signin_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/pages/signup_page.dart';
import 'package:synew_gym/pages/tab_bar_page.dart';
import 'package:synew_gym/widgets/error_dialog.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/my_text_field.dart';
import 'package:synew_gym/widgets/social_sign_in.dart';
import 'package:synew_gym/widgets/text_with_lines.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    context.read<SignInCubit>().signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
      if (state.signInStatus == SignInStatus.error) {
        errorDialog(context, state.error);
      }
      if (state.signInStatus == SignInStatus.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, TabBarPage.routeName, (route) => false);
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height * .9,
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color as Color),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(
                                flex: 6,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 4,
                        ),
                        MyTextField(
                          hintText: "Email",
                          maxLength: 50,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.grey),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is Required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        MyTextField(
                          hintText: "Password",
                          obscureText: true,
                          maxLength: 20,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.grey,
                          ),
                          passwordSuffix: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password is Required';
                            }
                            if (value.length < 6) {
                              return 'Password must be atleast 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(28, 102, 238, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        MyButton(
                          buttonText: 'Sign In',
                          buttonColor: primaryColor,
                          buttonWidth: size.width * 0.90,
                          buttonHeight: size.height * .06,
                          buttonAction:
                              state.signInStatus == SignInStatus.submitting
                                  ? null
                                  : _submit,
                          isSubmitting:
                              state.signInStatus == SignInStatus.submitting
                                  ? true
                                  : false,
                          isOutlined: false,
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: TextWithLines(text: "or continue with"),
                        ),
                        const Spacer(),
                        const SocialSignIn(
                          calledFrom: SocialSignCalledFrom.signin,
                        ),
                        const Spacer(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Account?",
                              style: GoogleFonts.urbanist(
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, SignUpPage.routeName);
                              },
                              child: Text(
                                ' Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
