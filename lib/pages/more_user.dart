import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synew_gym/blocs/signin/signin_cubit.dart';
import 'package:synew_gym/pages/nutrition_page.dart';

import 'package:synew_gym/widgets/error_dialog.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/my_text_field.dart';

class MoreUser extends StatefulWidget {
  static const String routeName = '/moreuser';
  const MoreUser({Key? key}) : super(key: key);

  @override
  MoreUserState createState() => MoreUserState();
}

class MoreUserState extends State<MoreUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    context.read<SignInCubit>();
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
            context, NutritionPage.routeName, (route) => false);
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Material(
          color: Colors.black,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height * .9,
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.arrowLeft,
                                    color: Colors.white),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              Text(
                                'Sign in',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
                        MyTextField(
                          hintText: "Username",
                          maxLength: 50,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.grey),
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Username is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        MyTextField(
                          hintText: "Full Name",
                          maxLength: 20,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.grey,
                          ),
                          controller: _fullnameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Fullname is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        MyButton(
                          buttonText: 'indate values',
                          buttonColor: const Color.fromRGBO(28, 102, 238, 1),
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
