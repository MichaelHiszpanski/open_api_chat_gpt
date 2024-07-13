import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppBlocObserver extends BlocObserver {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    final timestamp = _formatter.format(DateTime.now());
    print(
        '$timestamp - [CREATE] Bloc - ${bloc.runtimeType} Created! Initial State: ${bloc.state}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    final timestamp = _formatter.format(DateTime.now());
    print('$timestamp - [EVENT] Bloc - ${bloc.runtimeType} Event: $event');
  }
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   // TODO: implement onEvent
  //   super.onEvent(bloc, event);
  // }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    final timestamp = _formatter.format(DateTime.now());
    print('$timestamp - [CHANGE] Bloc - ${bloc.runtimeType} Change: ${change}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    final timestamp = _formatter.format(DateTime.now());
    print(
        '$timestamp - [TRANSITION] Bloc - ${bloc.runtimeType} Transition: ${transition}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final timestamp = _formatter.format(DateTime.now());
    print(
        '$timestamp - [ERROR] Bloc - ${bloc.runtimeType} Error: $error, StackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    final timestamp = _formatter.format(DateTime.now());
    print(
        '$timestamp - [CLOSE] Bloc - ${bloc.runtimeType} Closed! Final State: ${bloc.state}');
    super.onClose(bloc);
  }
}
