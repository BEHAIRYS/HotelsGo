class DateTimeFormatter extends DateTime {
  DateTimeFormatter(super.year);
  @override
  String toString() {
    return '${this.year}-${this.month}-${this.day}';
  }
}
