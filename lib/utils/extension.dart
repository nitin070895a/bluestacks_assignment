
extension Validation on String {

  bool isValidUsername() => this.length >= 3 && this.length <= 11;
  bool isValidPassword() => this.length >= 3 && this.length <= 11;
}