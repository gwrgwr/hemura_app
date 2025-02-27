class DateOperations {
  static String getWeekDayPT () {
    final weekdays = ["Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado", "Domingo"];
    final date = DateTime.now();
    final weekDayNumber = date.weekday;
    return weekdays.elementAt(weekDayNumber - 1);
  }

  static String getWeekDayENG () {
    final weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    final date = DateTime.now();
    final weekDayNumber = date.weekday;
    return weekdays.elementAt(weekDayNumber - 1);
  }
}