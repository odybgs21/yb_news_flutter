import '../../domain/entities/counter_entity.dart';

class CounterModel extends CounterEntity {
  const CounterModel({required super.count});

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {'count': count};
  }
}
