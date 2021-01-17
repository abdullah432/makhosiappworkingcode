class DayTimeModel {
  int _startHours;
  int _endHours;
  int _startMinutes;
  int _endMinutes;

  int get startHours => _startHours;

  set startHours(int value) {
    _startHours = value;
  }

  int get endHours => _endHours;

  int get endMinutes => _endMinutes;

  set endMinutes(int value) {
    _endMinutes = value;
  }

  int get startMinutes => _startMinutes;

  set startMinutes(int value) {
    _startMinutes = value;
  }

  set endHours(int value) {
    _endHours = value;
  }
}
