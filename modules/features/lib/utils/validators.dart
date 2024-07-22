String? validateNickname(String? name) {
  if (name!.isEmpty) {
    return 'Nickname Required';
  }
  if (name.trim().length > 20) {
    return 'Nickname must be 20 characters or less';
  }
  return null;
}


String? validateUAEPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  // Remove any whitespace or special characters
  String cleanedNumber = value.replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp(r'[()-]'), '');

  // UAE phone numbers typically start with 05, 04, 02, 03, 06, 07, 09
  // They are 9 digits long (excluding the country code)
  RegExp uaePhoneRegex = RegExp(r'^(0[2-9])\d{8}$');

  if (!uaePhoneRegex.hasMatch(cleanedNumber)) {
    return 'Enter a valid UAE phone number';
  }

  return null;
}