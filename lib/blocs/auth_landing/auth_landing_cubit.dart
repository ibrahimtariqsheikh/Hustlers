import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/repositories/auth_repository.dart';

part 'auth_landing_state.dart';

class AuthLandingCubit extends Cubit<AuthLandingState> {
  final AuthRepository authRepository;
  AuthLandingCubit({
    required this.authRepository,
  }) : super(AuthLandingState.initial());

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(
      authLandingStatus: AuthLandingStatus.submitting,
    ));
    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(
        authLandingStatus: AuthLandingStatus.success,
      ));
    } on CustomError catch (e) {
      emit(
          state.copyWith(authLandingStatus: AuthLandingStatus.error, error: e));
    }
  }

  Future<void> signInWithTwitter() async {
    emit(state.copyWith(
      authLandingStatus: AuthLandingStatus.submitting,
    ));
    try {
      await authRepository.signInWithTwitter();
      emit(state.copyWith(
        authLandingStatus: AuthLandingStatus.success,
      ));
    } on CustomError catch (e) {
      emit(
          state.copyWith(authLandingStatus: AuthLandingStatus.error, error: e));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(
      authLandingStatus: AuthLandingStatus.submitting,
    ));
    try {
      await authRepository.signInWithFacebook();
      emit(state.copyWith(
        authLandingStatus: AuthLandingStatus.success,
      ));
    } on CustomError catch (e) {
      emit(
          state.copyWith(authLandingStatus: AuthLandingStatus.error, error: e));
    }
  }
}
