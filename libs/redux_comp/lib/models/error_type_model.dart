// represents the different kinds of errors
enum ErrorType {
  // no error
  none,
  // login errors
  userNotFound, // avoid using and rather give more descriptive error
  userNotVerified, // user created, but email not verified
  passwordAttemptsExceeded, // user entered the wrong password too many times
  userInvalidPassword, // if the passwoird is invalid
  // registration errors
  locationNotCaptured, // the location was null when trying to create a user
  domainsNotCaptured, // domains was null when trying to create a user
  tradeTypesNotCaptured, // tradetypes was null when trying to create a user
  // adding user to db errors
  failedToAddUserToGroup, // if the user is not verified, it will not add the user to a usergroup
  failedToCreateUser, // user created, but email not verified
  // modifying errors
  failedToEditUser, // user created, but email not verified
  advertContainsBids, // cannot modify and add with bids
  // generic errors
  noInput,
  //
}

// for use later, have each error typer return its own message
// add optional paramters
String errorMsg(ErrorType e) {
  return "";
}
