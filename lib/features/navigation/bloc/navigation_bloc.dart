import 'package:bloc/bloc.dart';

import 'package:kanban/features/navigation/bloc/navigation_event.dart';
import 'package:kanban/features/navigation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial()) {
    on<NavigationIndexUpdated>((event, emit) {
      emit(NavigationUpdateIndex(event.index));
    });
  }
}
