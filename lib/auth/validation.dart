String? emailValidation(String? value) {
  if (value == null || value.isEmpty || !value.contains('@')) {
    return 'Enter a valid email';
  }
  return null;
}

String? nameValidation(String? value) {
  if (value == null || value.isEmpty ) {
    return 'Enter a valid name';
  }
  return null;
}

String? passwordValidation(String? value) {
  if (value == null || value.length < 6) {
    return 'Password requires at least 6 characters';
  }
  return null;
}