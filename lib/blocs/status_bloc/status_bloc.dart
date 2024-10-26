import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_event.dart';

part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(const StatusState(status: Statuses.wait)) {
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
      emit(state.copyWith(status: Statuses.activated));
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

  void deviceActivate() {
    add(ActivateStatusEvent());
  }

  void devicePause() {
    add(PauseStatusEvent());
  }
}
