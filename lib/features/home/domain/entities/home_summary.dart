class HomeSummary {
  final String welcomeMessage;
  final int activeUsersCount;
  final int pendingTasksCount;

  const HomeSummary({
    required this.welcomeMessage,
    required this.activeUsersCount,
    required this.pendingTasksCount,
  });
}
