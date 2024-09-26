bool isValidEmailAddress(String it) =>
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(it);

String? isValidPassword(String it) {
  if (it.length < 8) {
    return "Password must be at least 8 characters long";
  }
  if (!RegExp(r'[A-Z]').hasMatch(it)) {
    return "Password must contain at least one uppercase letter";
  }
  if (!RegExp(r'[a-z]').hasMatch(it)) {
    return "Password must contain at least one lowercase letter";
  }
  if (!RegExp(r'[0-9]').hasMatch(it)) {
    return "Password must contain at least one number";
  }
  return null;
}

String capitalize(String it) => it.isEmpty
    ? it
    : it[0].toUpperCase() + it.substring(1, it.length).toLowerCase();

String capitalizeEach(String it) => it.split(" ").map(capitalize).join(" ");
