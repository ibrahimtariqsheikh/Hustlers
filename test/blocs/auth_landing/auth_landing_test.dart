import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:synew_gym/blocs/auth/repository/auth_repository.dart';
import 'package:synew_gym/blocs/auth_landing/cubit/auth_landing_cubit.dart';
import 'package:synew_gym/models/custom_error.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthLandingCubit authLandingCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authLandingCubit = AuthLandingCubit(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authLandingCubit.close();
  });

  blocTest<AuthLandingCubit, AuthLandingState>(
    'emits [submitting, success] when signInWithGoogle succeeds',
    build: () {
      when(() => mockAuthRepository.signInWithGoogle())
          .thenAnswer((_) async {});
      return authLandingCubit;
    },
    act: (cubit) => cubit.signInWithGoogle(),
    expect: () => [
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.submitting,
          error: CustomError()),
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.success, error: CustomError()),
    ],
  );

  blocTest<AuthLandingCubit, AuthLandingState>(
    'emits [submitting, success] when signInWithFacebook succeeds',
    build: () {
      when(() => mockAuthRepository.signInWithFacebook())
          .thenAnswer((_) async {});
      return authLandingCubit;
    },
    act: (cubit) => cubit.signInWithFacebook(),
    expect: () => [
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.submitting,
          error: CustomError()),
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.success, error: CustomError()),
    ],
  );

  blocTest<AuthLandingCubit, AuthLandingState>(
    'emits [submitting, success] when signInWithTwitter succeeds',
    build: () {
      when(() => mockAuthRepository.signInWithTwitter())
          .thenAnswer((_) async {});
      return authLandingCubit;
    },
    act: (cubit) => cubit.signInWithTwitter(),
    expect: () => [
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.submitting,
          error: CustomError()),
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.success, error: CustomError()),
    ],
  );

  blocTest<AuthLandingCubit, AuthLandingState>(
    'emits [submitting, error] when signInWithGoogle fails',
    build: () {
      when(() => mockAuthRepository.signInWithGoogle()).thenThrow(
          const CustomError(
              code: 'error', message: 'message', plugin: 'plugin'));
      return authLandingCubit;
    },
    act: (cubit) => cubit.signInWithGoogle(),
    expect: () => [
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.submitting,
          error: CustomError()),
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.error,
          error:
              CustomError(code: 'error', message: 'message', plugin: 'plugin')),
    ],
  );

  blocTest<AuthLandingCubit, AuthLandingState>(
    'emits [submitting, error] when signInWithFacebook fails',
    build: () {
      when(() => mockAuthRepository.signInWithFacebook()).thenThrow(
          const CustomError(
              code: 'error', message: 'message', plugin: 'plugin'));
      return authLandingCubit;
    },
    act: (cubit) => cubit.signInWithFacebook(),
    expect: () => [
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.submitting,
          error: CustomError()),
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.error,
          error:
              CustomError(code: 'error', message: 'message', plugin: 'plugin')),
    ],
  );

  blocTest<AuthLandingCubit, AuthLandingState>(
    'emits [submitting, error] when signInWithTwitterfails',
    build: () {
      when(() => mockAuthRepository.signInWithTwitter()).thenThrow(
          const CustomError(
              code: 'error', message: 'message', plugin: 'plugin'));
      return authLandingCubit;
    },
    act: (cubit) => cubit.signInWithTwitter(),
    expect: () => [
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.submitting,
          error: CustomError()),
      const AuthLandingState(
          authLandingStatus: AuthLandingStatus.error,
          error:
              CustomError(code: 'error', message: 'message', plugin: 'plugin')),
    ],
  );
}
