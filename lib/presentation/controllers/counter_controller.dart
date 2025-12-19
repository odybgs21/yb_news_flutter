import 'package:get/get.dart';
import '../../domain/usecases/get_counter_usecase.dart';
import '../../domain/usecases/increment_counter_usecase.dart';

class CounterController extends GetxController {
  final GetCounterUseCase getCounterUseCase;
  final IncrementCounterUseCase incrementCounterUseCase;

  CounterController({
    required this.getCounterUseCase,
    required this.incrementCounterUseCase,
  });

  var count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCounter();
  }

  void fetchCounter() async {
    final result = await getCounterUseCase();
    count.value = result.count;
  }

  void increment() async {
    final result = await incrementCounterUseCase();
    count.value = result.count;
  }
}
