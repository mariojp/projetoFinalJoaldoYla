import 'package:projetofinal_mobile/src/core/constants/string_constants.dart';

/// A classe [FormatterUtil] é responsável por gerenciar os métodos de utilidades de formatação utilizados no projeto.
class FormatterUtil {
  ///Formata a data que vem da API.
  static String dateFromAPI(String date) {
    final dateResult = date.substring(0, 10).split(StringConstants.hyphen);

    return dateResult[2] +
        StringConstants.slash +
        dateResult[1] +
        StringConstants.slash +
        dateResult[0];
  }

  static String dateFromAPIv2(String date) {
    var dateSplit = date.split(StringConstants.at);

    var split = dateSplit[0].split(StringConstants.hyphen);
    return split[0] +
        StringConstants.slash +
        split[1] +
        StringConstants.slash +
        split[2];
  }
}
