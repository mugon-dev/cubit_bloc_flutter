import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  // CounterState의 factory constructor 가져오
  // 모든 cubit에는 state와 strean애 내보내는 emit함수가 주어짐
  // state => state.counter
  // emit => emit(state.copyWith(counter : state.counter +1))
  // copyWith로 새로운 state를 만들어 반환
  CounterCubit() : super(CounterState.initial());

  void increment() {
    final newState = state.copyWith(counter: state.counter + 1);
    print(newState);
    emit(newState);
  }

  void decrement() {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
