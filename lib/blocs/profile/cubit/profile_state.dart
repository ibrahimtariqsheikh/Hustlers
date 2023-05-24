// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final User user;
  final CustomError error;
  final HealthData healthData;

  const ProfileState({
    required this.status,
    required this.user,
    required this.error,
    required this.healthData,
  });

  factory ProfileState.initial() {
    return ProfileState(
      status: ProfileStatus.initial,
      user: User.initial(),
      error: const CustomError(),
      healthData: HealthData(
        heartRate: 'N/A',
        sleepInBed: 'N/A',
        steps: 'N/A',
        distanceWalking: 'N/A',
      ),
    );
  }

  @override
  List<Object?> get props => [status, user, error];

  ProfileState copyWith({
    ProfileStatus? status,
    User? user,
    CustomError? error,
    HealthData? healthData,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
      healthData: healthData ?? this.healthData,
    );
  }

  @override
  bool get stringify => true;
}
