// represents the different kinds of errors
enum ErrorType {
  none, // no error
  userNotFound, // avoid using and rather give more descriptive error
  userNotVerified, // user created, but email not verified
  userInvalidPassword,
  passwordAttemptsExceeded, // user created, but email not verified
  failedToAddUserToGroup, // user created, but email not verified
  failedToCreateUser, // user created, but email not verified
}

// for use later, have each error typer return its own message
// add optional paramters
String errorMsg(ErrorType e) {
  return "";
}
