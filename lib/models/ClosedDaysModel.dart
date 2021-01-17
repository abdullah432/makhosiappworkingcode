class ClosedDaysModel {
  int _dayOfWeek;
  bool _isOpen;

  int get dayOfWeek => _dayOfWeek;

  set dayOfWeek(int value) {
    _dayOfWeek = value;
  }

  bool get isOpen => _isOpen;

  set isOpen(bool value) {
    _isOpen = value;
  }
}
