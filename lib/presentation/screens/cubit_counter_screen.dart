import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  void increaseCounterBy(BuildContext context, [int value = 1]) {
    context.read<CounterCubit>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {
    // final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        //* Mejor manera de obtener datos con Cubits
        title: context.select((CounterCubit value) {
          return Text('Cubit Counter: ${value.state.transactionCount}');
        }),
        actions: [
          //* Refresh Counter
          IconButton(
            onPressed: () {
              context.read<CounterCubit>().reset();
            },
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => increaseCounterBy(context, 3),
            child: const Text('+3'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () => increaseCounterBy(context, 2),
            child: const Text('+2'),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () => increaseCounterBy(context, 1),
            child: const Text('+1'),
          ),
        ],
      ),
      body: _CubitCounterText(),
    );
  }
}

class _CubitCounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      //* Buena manera, pero no es la mejor para obtener estados en Cubits
      child: BlocBuilder<CounterCubit, CounterState>(
        // buildWhen: (previous, current) => current.counter != previous.counter,
        builder: (context, state) {
          print('Counter Render');
          final themeText = Theme.of(context).textTheme;

          return Text.rich(
            TextSpan(
              text: 'Counter Value: ',
              style: themeText.titleLarge,
              children: [
                TextSpan(text: state.counter.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
