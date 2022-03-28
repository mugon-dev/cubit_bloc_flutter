// 모든 state를 class를 만들어 관리
// 장점
// 1. 일관성 유지
// 2. 타입 충돌 방지

// bloc state 만드는 기본 방식
// 1. equatable을 extends하는 abstract state class  생성
// 2. 나머지 클래스는 state 클래스를 extends
// 3. 사용자에게 보여줄 initial state (CounterInitial)
// 4. 값을 읽어오고 있다는 것을 사용자에게 표시 (CounterLoadInProgress)
// 5. 읽어오는 것을 실패했을때 표시 (CounterLoadFailure)
// 6. 읽어온 것을 성공했을때 그 값을 표시 (CounterLoadSuccess)
part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counter;
  CounterState({
    required this.counter,
  });

  // Counter 값이 0인 CounterState instance 리턴
  factory CounterState.initial() {
    return CounterState(counter: 0);
  }

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
