import '../../domain/entities/counter_entity.dart';
import '../../domain/repositories/counter_repository.dart';
import '../providers/counter_provider.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterProvider provider;

  CounterRepositoryImpl({required this.provider});

  @override
  Future<CounterEntity> getCounter() async {
    return await provider.getCounter();
  }

  @override
  Future<CounterEntity> incrementCounter() async {
    return await provider.incrementCounter();
  }
}
