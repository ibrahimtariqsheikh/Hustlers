import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synew_gym/blocs/auth/repository/auth_repository.dart';
import 'package:synew_gym/blocs/signin/cubit/signin_cubit.dart';
import 'package:synew_gym/models/custom_error.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SignInCubit', () {
    late AuthRepository authRepository;
    late SignInCubit signInCubit;

    setUp(() {
      authRepository = MockAuthRepository();
      signInCubit = SignInCubit(authRepository: authRepository);
    });

    tearDown(() {
      signInCubit.close();
    });

    test('initial state is correct', () {
      expect(signInCubit.state, equals(SignInState.initial()));
    });

    blocTest<SignInCubit, SignInState>(
      'signInWithEmail emits [submitting, success] states on successful sign-in',
      build: () => signInCubit,
      act: (cubit) async {
        await cubit.signIn(email: 'test@example.com', password: 'password');
      },
      expect: () => [
        SignInState(
          signInStatus: SignInStatus.submitting,
          error: CustomError(),
        ),
        SignInState(
          signInStatus: SignInStatus.success,
          error: CustomError(),
        ),
      ],
      verify: (_) {
        verify(authRepository.signInWithEmail(
          email: 'test@example.com',
          password: 'password',
        )).called(1);
      },
    );

    blocTest<SignInCubit, SignInState>(
      'signInWithEmail emits [submitting, error] states on sign-in error',
      build: () => signInCubit,
      act: (cubit) async {
        when(authRepository.signInWithEmail(
          email: 'test@example.com',
          password: 'password',
        )).thenThrow(
          CustomError(code: 'ERROR', message: 'Sign-in failed'),
        );

        await cubit.signIn(email: 'test@example.com', password: 'password');
      },
      expect: () => [
        SignInState(
          signInStatus: SignInStatus.submitting,
          error: CustomError(),
        ),
        SignInState(
          signInStatus: SignInStatus.error,
          error: CustomError(code: 'ERROR', message: 'Sign-in failed'),
        ),
      ],
      verify: (_) {
        verify(authRepository.signInWithEmail(
          email: 'test@example.com',
          password: 'password',
        )).called(1);
      },
    );

    blocTest<SignInCubit, SignInState>(
      'signInWithGoogle emits [submitting, success] states on successful sign-in',
      build: () => signInCubit,
      act: (cubit) async {
        await cubit.signInWithGoogle();
      },
      expect: () => [
        const SignInState(
          signInStatus: SignInStatus.submitting,
          error: CustomError(),
        ),
        const SignInState(
          signInStatus: SignInStatus.success,
          error: CustomError(),
        ),
      ],
      verify: (_) {
        verify(authRepository.signInWithGoogle()).called(1);
      },
    );

    blocTest<SignInCubit, SignInState>(
      'signInWithTwitter emits [submitting, success] states on successful sign-in',
      build: () => signInCubit,
      act: (cubit) async {
        await cubit.signInWithTwitter();
      },
      expect: () => [
        SignInState(
          signInStatus: SignInStatus.submitting,
          error: CustomError(),
        ),
        SignInState(
          signInStatus: SignInStatus.success,
          error: CustomError(),
        ),
      ],
      verify: (_) {
        verify(authRepository.signInWithTwitter()).called(1);
      },
    );

    blocTest<SignInCubit, SignInState>(
      'signInWithFacebook emits [submitting, success] states on successful sign-in',
      build: () => signInCubit,
      act: (cubit) async {
        await cubit.signInWithFacebook();
      },
      expect: () => [
        SignInState(
          signInStatus: SignInStatus.submitting,
          error: CustomError(),
        ),
        SignInState(
          signInStatus: SignInStatus.success,
          error: CustomError(),
        ),
      ],
      verify: (_) {
        verify(authRepository.signInWithFacebook()).called(1);
      },
    );
  });
}
