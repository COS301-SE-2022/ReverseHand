// represents the different kinds of errors
enum ErrorType {
  none, // no error
  userNotFound, // avoid using and rather give more descriptive error
  userNotVerified, // user created, but email not verified
  userInvalidPassword,
  passwordAttemptsExceeded, // user entered the wrong password too many times
  failedToAddUserToGroup, // if the user is not verified, it will not add the user to a usergroup
  failedToCreateUser, // user created, but email not verified
  locationNotCaptured, // the location was null when trying to create a user
  domainsNotCaptured, // domains was null when trying to create a user
  tradeTypesNotCaptured, // tradetypes was null when trying to create a user
}

// for use later, have each error typer return its own message
// add optional paramters
String errorMsg(ErrorType e) {
  return "";
}
