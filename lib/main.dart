/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
    }
  }

  //void increment() => emit(state + 100);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: Center(
          child: CounterText(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // BlocProvider.of<CounterBloc>(context).increment();
            context.read<CounterBloc>().add(CounterEvent.increment);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}

class CounterText extends StatelessWidget {
  const CounterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterBloc>().state;

    return Text(
      '$count',
      style: TextStyle(fontSize: 100),
    );
  }
}
 */


import 'package:bloc_practice/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/business_logic/cubit/internet_cubit.dart';
import 'package:bloc_practice/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  MyApp({required this.appRouter, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity)),
        BlocProvider<CounterCubit>(
            create: (ctx) =>
                CounterCubit(internetCubit: ctx.read<InternetCubit>())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
