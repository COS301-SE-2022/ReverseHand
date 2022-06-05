// represents the different kinds of errors
enum ErrorType {
  none, // no error
  notFound, // avoid using and rather give more descriptive error
}

// for use later, have each error typer return its own message
// add optional paramters
String errorMsg(ErrorType e) {
  return "";
}
