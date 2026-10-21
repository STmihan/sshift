const minutesPerDay = 24 * 60;

mixin TimeSpan {
  bool get allDay;

  int get startMinute;

  int get endMinute;

  int get breakMinutes => 0;

  bool get endsNextDay => !allDay && endMinute <= startMinute;

  int get spanMinutes {
    if (allDay) {
      return minutesPerDay;
    }

    final diff = endMinute - startMinute;

    return diff > 0 ? diff : diff + minutesPerDay;
  }

  int get workedMinutes => (spanMinutes - breakMinutes).clamp(0, minutesPerDay);
}
