// represents the different kinds of errors
enum ErrorType {
  // no error
  none,
  // login errors
  userNotAuthorised, // the user is not signed in
  userNotInGroup, // the user does not have a relevant group
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
  // cognito errors
  failedToRefreshToken,
  failedToReadGroup,
  // modifying errors
  failedToEditUser, // user created, but email not verified
  advertContainsBids, // cannot modify and add with bids
  failedToAddReview, //when adding a review fails
  // generic errors
  noInput,
  //
}

// for use later, have each error typer return its own message
// add optional paramters
String errorMsg(ErrorType e) {
  return "";
}
