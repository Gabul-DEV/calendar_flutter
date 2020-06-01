extension WeekDay on int {
  String get week {
    switch (this) {
      case 0:
        return "dom";
      case 1:
        return "seg";
      case 2:
        return "ter";
      case 3:
        return "qua";
      case 4:
        return "qui";
      case 5:
        return "sex";
      case 6:
        return "sáb";
        break;
      default:
        throw "INVALID WEEK";
    }
  }
}

extension Month on int {
  String get month {
    switch (this) {
      case 1:
        return "Janeiro";
      case 2:
        return "Feveiro";
      case 3:
        return "Março";
      case 4:
        return "Abril";
      case 5:
        return "Maio";
      case 6:
        return "Junho";
      case 7:
        return "Julho";
      case 8:
        return "Agosto";
      case 9:
        return "Setembro";
      case 10:
        return "Outubro";
      case 11:
        return "Novembro";
      case 12:
        return "Dezembro";

        break;
      default:
        throw "INVALID MONTH";
    }
  }
}
