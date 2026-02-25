class AuthService {
  static bool loggedIn = false;
  static bool firstRun = true;

  static void setLoggedIn(bool value) {
    loggedIn = value;
  }

  static bool isLoggedInSync() => loggedIn;

  static void setFirstRun(bool value) {
    firstRun = value;
  }

  static bool isFirstRunSync() => firstRun;
}
