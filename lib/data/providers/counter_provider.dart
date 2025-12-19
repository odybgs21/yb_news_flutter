import '../models/counter_model.dart';

class CounterProvider {
  int _count = 0;

  Future<CounterModel> getCounter() async {
    return CounterModel(count: _count);
  }

  Future<CounterModel> incrementCounter() async {
    _count++;
    return CounterModel(count: _count);
  }
}
