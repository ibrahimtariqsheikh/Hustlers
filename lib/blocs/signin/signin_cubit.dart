import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/repositories/auth_repository.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  SignInCubit({
    required this.authRepository,
  }) : super(SignInState.initial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      signInStatus: SignInStatus.submitting,
    ));
    try {
      await authRepository.signInWithEmail(email: email, password: password);
      emit(state.copyWith(
        signInStatus: SignInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signInStatus: SignInStatus.error, error: e));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(
      signInStatus: SignInStatus.submitting,
    ));
    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(
        signInStatus: SignInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signInStatus: SignInStatus.error, error: e));
    }
  }

  Future<void> signInWithTwitter() async {
    emit(state.copyWith(
      signInStatus: SignInStatus.submitting,
    ));
    try {
      await authRepository.signInWithTwitter();
      emit(state.copyWith(
        signInStatus: SignInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signInStatus: SignInStatus.error, error: e));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(
      signInStatus: SignInStatus.submitting,
    ));
    try {
      await authRepository.signInWithFacebook();
      emit(state.copyWith(
        signInStatus: SignInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signInStatus: SignInStatus.error, error: e));
    }
  }
}
