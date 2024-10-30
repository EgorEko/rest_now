import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_event.dart';

part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc()
      : super(
          const StatusState(
            status: Statuses.wait,
            id: '',
            timeOut: 0,
            timePause: 0,
          ),
        ) {
    on<WaitStatusEvent>((event, emit) {
      if (state.status == Statuses.wait) {
        return;
      }
      emit(state.copyWith(status: Statuses.wait));
    });
    on<ActivateStatusEvent>((event, emit) {
      if (state.status == Statuses.activated) {
        return;
      }
      emit(
        state.copyWith(
          status: Statuses.activated,
          id: event.id,
          timeOut: event.timeOut,
          timePause: event.timePause,
        ),
      );
    });
    on<PauseStatusEvent>((event, emit) {
      if (state.status == Statuses.pause) {
        return;
      }
      emit(state.copyWith(status: Statuses.pause));
    });
  }

  void wait() {
    add(WaitStatusEvent());
  }

  void deviceActivate({
    required String id,
    required num timeOut,
    required num timePause,
  }) {
    add(ActivateStatusEvent(id: id, timeOut: timeOut, timePause: timePause));
  }

  void devicePause() {
    add(PauseStatusEvent());
  }
}
