class Time {
  static String date(DateTime dateTime) {
    return '${dateTime.day} ${_month(dateTime.month)} ${dateTime.year}';
  }

  static String hour(DateTime dateTime) {
    return " ${dateTime.hour}:" + _addCero(dateTime.minute);
  }

  static String dateTimeFiles(DateTime dateTime) {
    return '${dateTime.day}_${_month(dateTime.month)}_${dateTime.year}_${dateTime.hour}-${_addCero(dateTime.minute)}';
  }

  static String dateFiles(DateTime dateTime) {
    return '${dateTime.day}_${_month(dateTime.month)}_${dateTime.year}';
  }

  static String dateTimeWithoutCompare(DateTime tiempo) {
    return "${tiempo.day} " +
        _month(tiempo.month) +
        " ${tiempo.hour}:" +
        _addCero(tiempo.minute);
  }

  static String dateTimeCompare(DateTime tiempo) {
    DateTime hoy = DateTime.now();
    if (hoy.day == tiempo.day &&
        hoy.month == tiempo.month &&
        hoy.year == tiempo.year) {
      return "Hoy ${tiempo.hour}:" + _addCero(tiempo.minute);
    } else {
      if ((hoy.day - 1) == tiempo.day &&
          hoy.month == tiempo.month &&
          hoy.year == tiempo.year) {
        return "Ayer" + " ${tiempo.hour}:" + _addCero(tiempo.minute);
      } else {
        return "${tiempo.day} " +
            _month(tiempo.month) +
            " ${tiempo.hour}:" +
            _addCero(tiempo.minute);
      }
    }
  }

  static String _month(int n) {
    switch (n) {
      case 1:
        return "ene";
      case 2:
        return "feb";
      case 3:
        return "mar";
      case 4:
        return "abr";
      case 5:
        return "may";
      case 6:
        return "jun";
      case 7:
        return "jul";
      case 8:
        return "ago";
      case 9:
        return "sep";
      case 10:
        return "oct";
      case 11:
        return "nov";
      case 12:
        return "dic";
      default:
        return "$n";
    }
  }

  static String _addCero(int n) {
    if (n < 10) {
      return "0$n";
    } else {
      return "$n";
    }
  }
}
