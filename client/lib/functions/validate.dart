class Validate {
  static String? email(String? value) {
    // ! usar diretamente o value sempre possibilida o valor null, mesmo com o return
    // ! não entendi o porque disse, então usei uma váriavel "auxiliar"

    if (value == null || value.isEmpty) {
      return 'Por favor digite seu email';
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Por favor digite um email válido';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite sua senha';
    }

    if (value.length <= 8) {
      return 'A senha precisa ter mais do que 8 caracteres';
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite seu username';
    }

    if (value.length <= 4) {
      return 'O username precisa ter mais do que 4 caracteres';
    }

    return null;
  }

  static String? correctPassword(String? value, String? password) {
    if (value != password) {
      return 'Suas senhas não são iguais';
    }

    return null;
  }
}
