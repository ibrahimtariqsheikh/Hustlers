// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_landing_cubit.dart';

enum AuthLandingStatus {
  initial,
  submitting,
  success,
  error,
}

class AuthLandingState extends Equatable {
  final AuthLandingStatus authLandingStatus;
  final CustomError error;

  const AuthLandingState({
    required this.authLandingStatus,
    required this.error,
  });

  factory AuthLandingState.initial() {
    return const AuthLandingState(
      authLandingStatus: AuthLandingStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object?> get props => [authLandingStatus, error];

  @override
  bool get stringify => true;

  AuthLandingState copyWith({
    AuthLandingStatus? authLandingStatus,
    CustomError? error,
  }) {
    return AuthLandingState(
      authLandingStatus: authLandingStatus ?? this.authLandingStatus,
      error: error ?? this.error,
    );
  }
}
