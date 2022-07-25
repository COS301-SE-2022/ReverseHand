// represents the different kinds of errors
enum ErrorType {
  none, // no error
  // login errors
  userNotFound, // avoid using and rather give more descriptive error
  userNotVerified, // user created, but email not verified
  userInvalidPassword, // if the passwoird is invalid
  passwordAttemptsExceeded, // user created, but email not verified

  // adding user to db errors
  failedToAddUserToGroup,
  failedToCreateUser,

  // generic errors
  noInput,
}

// for use later, have each error typer return its own message
// add optional paramters
String errorMsg(ErrorType e) {
  return "";
}
