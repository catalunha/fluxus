import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ErrorCodes {
  final ParseError parseError;
  ErrorCodes(
    this.parseError,
  ) {
    decode();
  }
  int code = 0;
  String message = '';
  decode() {
    if (_appCodes.containsKey(parseError.code)) {
      code = parseError.code;
      message = _appCodes[parseError.code]!;
    } else {
      log('${parseError.code} - ${parseError.message} - ${parseError.type}',
          name: 'ErroNaoDocumentado');
      code = parseError.code;
      message = parseError.message;
    }
  }

  final Map<int, String> _appCodes = {
    101: 'Email ou senha inválidos.',
    202: 'Já existe uma conta para este email.',
    205: 'Veja seu email para validar seu cadastro.',
  };
}
