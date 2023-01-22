String? emailValidation(String? value) {
  if (value == null || value.isEmpty || !value.contains('@')) {
    return 'Enter a valid email';
  }
  return null;
}

String? nameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter a valid name';
  }
  return null;
}

String? passwordValidation(String? value) {
  if (value == null || value.length < 8) {
    return 'Password requires at least 8 characters';
  }
  return null;
}
