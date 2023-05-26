part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncreased extends CounterEvent {
  final int value;

  const CounterIncreased(this.value);
}

class CounterReset extends CounterEvent {}
