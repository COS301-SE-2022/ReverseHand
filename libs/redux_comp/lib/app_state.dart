class AppState {
  // put all app state requiered here
  final String example; // remove later

  // constructor must only take named parameters
  AppState({required this.example});

  // this methods sets the starting state for the store
  static AppState initial() {
    return AppState(example: "example");
  }
}
