// function used for creating validators

String? Function(String?) createValidator(
      String kind, String invalidMsg, RegExp regex) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'A $kind must be entered';
      }

      if (!regex.hasMatch(value)) {
        return "${kind[0].toUpperCase() + kind.substring(1)} $invalidMsg";
      }

      return null;
    };
  }
