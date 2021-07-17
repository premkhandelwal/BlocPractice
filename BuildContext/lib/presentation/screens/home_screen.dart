import 'package:bloc_practice/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/business_logic/cubit/internet_cubit.dart';
import 'package:bloc_practice/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);
  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.WiFi)
                return Text("Wifi");
              else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Mobile)
                return Text("Mobile");
              else if (state is InternetDisconnected) {
                return Text("Disconnected");
              } else {
                return CircularProgressIndicator();
              }
            }),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Incremented"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Decremented"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    "BRR NEGATIVE ${state.counterValue}",
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    "Yay even ${state.counterValue}",
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    "Hmm You got ${state.counterValue}",
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  "You got ${state.counterValue}",
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;
              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text("Counter: ${counterState.counterValue}" +
                    " Internet: Mobile");
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.WiFi) {
                return Text("Counter: ${counterState.counterValue}" +
                    " Internet: WIFI");
              } else {
                return Text("Counter: ${counterState.counterValue}" +
                    " Internet: DisConnected");
              }
            }),
            SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              final counterValue = context
                  .select((CounterCubit value) => value.state.counterValue);
              return Text("Counter: $counterValue");
            }),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: "Decrement",
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  heroTag: "btn2",
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: "Increment",
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 34,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.of(context).pushNamed("/second");
              },
              child: Text('Go to Second Page'),
            ),
            MaterialButton(
              color: Colors.amberAccent,
              onPressed: () {
                Navigator.of(context).pushNamed("/third");
              },
              child: Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}
