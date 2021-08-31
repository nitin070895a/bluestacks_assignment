
/// Extension functions over string to handle all different kinds of validations
extension Validation on String {

  /// Returns true if the string is a valid username otherwise returns false
  bool isValidUsername() => this.length >= 3 && this.length <= 11;

  /// Returns true if the string is a valid password otherwise returns false
  bool isValidPassword() => this.length >= 3 && this.length <= 11;
}