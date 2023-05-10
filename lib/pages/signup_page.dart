import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synew_gym/blocs/signup/signup_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/pages/signin_page.dart';
import 'package:synew_gym/pages/tab_bar_page.dart';
import 'package:synew_gym/widgets/error_dialog.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/my_text_field.dart';
import 'package:synew_gym/widgets/mydropdown.dart';
import 'package:synew_gym/widgets/social_sign_in.dart';
import 'package:synew_gym/widgets/text_with_lines.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
  }

  void _signUp() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    context.read<SignUpCubit>().signUp(
        firstname: _firstnameController.text.trim(),
        lastname: _lastnameController.text.trim(),
        gender: context.read<SignUpCubit>().state.selectedGender,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.signUpStatus == SignUpStatus.error) {
          errorDialog(context, state.error);
        }
        if (state.signUpStatus == SignUpStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, TabBarPage.routeName, (route) => false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height * .9,
                    width: size.width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color as Color,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                const Spacer(
                                  flex: 3,
                                ),
                                Text(
                                  'Sign Up',
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
                            flex: 3,
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          MyTextField(
                            hintText: "First Name",
                            maxLength: 20,
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.grey),
                            controller: _firstnameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First Name is Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          MyTextField(
                            hintText: "Last Name",
                            maxLength: 20,
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.grey),
                            controller: _lastnameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Last Name is Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          MyDropdown(
                            hintText: "Gender",
                            value: context
                                .read<SignUpCubit>()
                                .state
                                .selectedGender,
                            onChanged: (String? newValue) {
                              context
                                  .read<SignUpCubit>()
                                  .updateSelectedGender(newValue ?? '');
                            },
                            items: const <String>['Male', 'Female'],
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Gender is Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * .015,
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
                            height: size.height * .03,
                          ),
                          MyButton(
                            buttonText: 'Sign Up',
                            buttonColor: primaryColor,
                            buttonWidth: size.width * 0.90,
                            buttonHeight: size.height * .06,
                            buttonAction: _signUp,
                            isSubmitting:
                                state.signUpStatus == SignUpStatus.submitting
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
                            calledFrom: SocialSignCalledFrom.signUp,
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
                                      context, SignInPage.routeName);
                                },
                                child: Text(
                                  ' Sign In',
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
      },
    );
  }
}
