class HealthData {
  final String heartRate;
  final String sleepInBed;
  final String steps;
  final String distanceWalking;

  HealthData({
    required this.heartRate,
    required this.sleepInBed,
    required this.steps,
    required this.distanceWalking,
  });

  factory HealthData.initial() {
    return HealthData(
        heartRate: 'N/A',
        sleepInBed: 'N/A',
        steps: 'N/A',
        distanceWalking: 'N/A');
  }
}
