import 'package:cubit_bloc_flutter/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provider는 cubit의 instance를 생성
    return BlocProvider<CounterCubit>(
      // lazy 방식으로 생성됨
      create: (context) => CounterCubit(),
      // child는 만들어진 instance에 접근할수 있는 of 라는 static 함수 제공
      // BlocProvider.of<CounterCubit><Context>
      // => dependency injection
      child: MaterialApp(
        title: 'MyCounter Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BlocConsumer = BlocListener + BlocBuilder
      body: BlocConsumer<CounterCubit, CounterState>(
        // listener는 builder와는 달리 state 변화에 한번만 호출이됨
        // 새로운 state에 반응하여 다이얼로그, 네비게이션 등의 원타임액션을 수행
        // return type이 void
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('counter is ${state.counter}'),
                );
              },
            );
          } else if (state.counter == -1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return OtherPage();
              }),
            );
          }
        },
        // builder 함수는 필요에 따라 flutter framework에서 추가로 호출할 수 있기 때문에
        // pure해야함
        builder: (context, state) {
          // BlocBuilder<CounterCubit, CounterState>(
          //   builder: (context, state) {
          //     return Center(
          //       child: Text(
          //         // BlocProvider.of<CounterCubit><Context,listen:true>.state.counter;
          //         '${state.counter}',
          //         style: TextStyle(fontSize: 52.0),
          //       ),
          //     )
          //   },
            return Center(
              child: Text(
                // BlocProvider.of<CounterCubit><Context,listen:true>.state.counter;
                '${state.counter}',
                style: TextStyle(fontSize: 52.0),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit><Context>.increment();
              context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit><Context>.decrement();
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
