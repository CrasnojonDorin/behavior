class WeatherData {
  double _temperature;
  double _humidity;
  double _pressure;

  WeatherData(this._temperature, this._humidity, this._pressure);

  void setMeasurements(double temperature, double humidity, double pressure) {
    _temperature = temperature;
    _humidity = humidity;
    _pressure = pressure;
    notifyObservers();
  }

  List<Observer> _observers = [];

  void registerObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void notifyObservers() {
    for (var observer in _observers) {
      observer.update(_temperature, _humidity, _pressure);
    }
  }
}

abstract class Observer {
  void update(double temperature, double humidity, double pressure);
}

class CurrentConditionsDisplay implements Observer {
  late double _temperature;
  late double _humidity;
  late double _pressure;

  void update(double temperature, double humidity, double pressure) {
    _temperature = temperature;
    _humidity = humidity;
    _pressure = pressure;
    display();
  }

  void display() {
    print(
        'Current conditions: $_temperature F degrees and $_humidity% humidity');
  }
}

void main() {
  var weatherData = WeatherData(80.0, 65.0, 30.4);
  var currentConditionsDisplay = CurrentConditionsDisplay();

  weatherData.registerObserver(currentConditionsDisplay);

  weatherData.setMeasurements(82.0, 70.0, 29.2);
  weatherData.setMeasurements(78.0, 90.0, 29.2);
  weatherData.removeObserver(currentConditionsDisplay);
  weatherData.setMeasurements(62.0, 60.0, 28.1);
}
