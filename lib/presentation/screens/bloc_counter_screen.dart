import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: _BlocCounterView(),
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  void increasedCounterBy(BuildContext context, [int value = 1]) {
    context.read<CounterBloc>().add(CounterIncreased(value));
  }

  void resetCounter(BuildContext context) {
    context.read<CounterBloc>().add(CounterReset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (CounterBloc value) => Text(
            'BLoC Counter: ${value.state.transactionCount}',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => resetCounter(context),
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => increasedCounterBy(context, 3),
            child: const Text('+3'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () => increasedCounterBy(context, 2),
            child: const Text('+2'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () => increasedCounterBy(context),
            child: const Text('+1'),
          ),
        ],
      ),
      body: _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: context.select(
        (CounterBloc value) => Text.rich(
          TextSpan(
            text: 'Counter Value:',
            children: [
              TextSpan(text: value.state.counter.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
