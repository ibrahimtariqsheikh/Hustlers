import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synew_gym/blocs/auth_landing/auth_landing_cubit.dart';
import 'package:synew_gym/constants/colors.dart';
import 'package:synew_gym/pages/signin_page.dart';
import 'package:synew_gym/pages/signup_page.dart';
import 'package:synew_gym/pages/tab_bar_page.dart';
import 'package:synew_gym/widgets/error_dialog.dart';
import 'package:synew_gym/widgets/login_button.dart';
import 'package:synew_gym/widgets/social_sign_in.dart';
import 'package:synew_gym/widgets/text_with_lines.dart';

class AuthLanding extends StatelessWidget {
  static const String routeName = '/authlanding';
  const AuthLanding({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthLandingCubit, AuthLandingState>(
      listener: (context, state) {
        if (state.authLandingStatus == AuthLandingStatus.error) {
          errorDialog(context, state.error);
        }
        if (state.authLandingStatus == AuthLandingStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, TabBarPage.routeName, (route) => false);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 4,
                    ),
                    Text(
                      'HUSTLERS',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 30, color: Theme.of(context).primaryColor),
                    ),
                    SvgPicture.asset(
                      'assets/icons/synew_logo.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Spacer(),
                    SocialButton(
                      height: size.height * .07,
                      width: size.width * .9,
                      icon: FontAwesomeIcons.facebook,
                      action: () =>
                          context.read<AuthLandingCubit>().signInWithFacebook(),
                      text: 'Continue With Facebook',
                    ),
                    const SizedBox(height: 10),
                    SocialButton(
                      height: size.height * .07,
                      width: size.width * .9,
                      icon: FontAwesomeIcons.google,
                      action: () async {
                        context.read<AuthLandingCubit>().signInWithGoogle();
                      },
                      text: 'Continue With Google',
                    ),
                    const SizedBox(height: 10),
                    SocialButton(
                      height: size.height * .07,
                      width: size.width * .9,
                      icon: FontAwesomeIcons.twitter,
                      action: () =>
                          context.read<AuthLandingCubit>().signInWithTwitter(),
                      text: 'Continue With Twitter',
                    ),
                    const Spacer(),
                    const TextWithLines(text: 'Or'),
                    const Spacer(),
                    MyButton(
                      buttonText: 'Log In With Password',
                      buttonColor: primaryColor,
                      buttonWidth: size.width * .9,
                      buttonHeight: size.height * .07,
                      buttonAction: () =>
                          Navigator.pushNamed(context, SignInPage.routeName),
                      isSubmitting: false,
                      isOutlined: false,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have an Account?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpPage.routeName);
                          },
                          child: Text(
                            ' Sign Up',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
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
    );
  }
}
