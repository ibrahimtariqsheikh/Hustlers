import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/blocs/auth/repository/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  Future<void> signUp({
    required String firstname,
    required String lastname,
    required String gender,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
    try {
      await authRepository.signUpWithEmail(
          firstname: firstname,
          lastname: lastname,
          gender: gender,
          email: email,
          password: password);
      emit(state.copyWith(signUpStatus: SignUpStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }

  void updateSelectedGender(String gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(
      signUpStatus: SignUpStatus.submitting,
    ));
    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }

  Future<void> signInWithTwitter() async {
    emit(state.copyWith(
      signUpStatus: SignUpStatus.submitting,
    ));
    try {
      await authRepository.signInWithTwitter();
      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(
      signUpStatus: SignUpStatus.submitting,
    ));
    try {
      await authRepository.signInWithFacebook();
      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }
}
