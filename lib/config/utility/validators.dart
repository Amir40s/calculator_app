class Validators {
  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? value, {String message = 'Enter a valid email'}) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) return message;
    return null;
  }

  static String? minLength(String? value, int minLength, {String? message}) {
    if (value == null || value.length < minLength) {
      return message ?? 'Minimum $minLength characters required';
    }
    return null;
  }

  static String? strongPassword(String? value, {String message = 'Password must include uppercase, number, and special char'}) {
    if (value == null || value.isEmpty) return 'Password is required';
    final strongRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!strongRegex.hasMatch(value)) return message;
    return null;
  }

  static String? match(String? value, String? other, {String message = 'Values do not match'}) {
    if (value != other) return message;
    return null;
  }

  static String? custom(String? value, RegExp pattern, {String message = 'Invalid input'}) {
    if (value == null || !pattern.hasMatch(value)) return message;
    return null;
  }
}