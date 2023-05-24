// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_cubit.dart';

enum SignInStatus {
  initial,
  submitting,
  success,
  error,
}

class SignInState extends Equatable {
  final SignInStatus signInStatus;
  final CustomError error;

  const SignInState({
    required this.signInStatus,
    required this.error,
  });

  factory SignInState.initial() {
    return const SignInState(
      signInStatus: SignInStatus.initial,
      error: CustomError(),
    );
  }

  @override
  String toString() =>
      'SignInState(signInStatus: $signInStatus, error: $error)';

  @override
  List<Object?> get props => [signInStatus, error];

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      error: error ?? this.error,
    );
  }
}
