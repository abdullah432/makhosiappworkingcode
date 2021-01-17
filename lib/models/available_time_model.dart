class AvailableTimeModel {
  int _openHours;
  int _closeHours;

  int get openHours => _openHours;

  AvailableTimeModel(this._openHours, this._closeHours);

  int get closeHours => _closeHours;
}
