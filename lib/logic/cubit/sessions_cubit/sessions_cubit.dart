import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/http/http_services.dart';
import '../../../data/models/chat_session.dart';
import '../../../data/shared/shared_services.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(SessionsInitial());

  Future loadSessions() async {
    try {
      emit(SessionsLoading());
      final int id = await SharedServices.getId();
      HttpServices services = HttpServices();
      final List<ChatSession> sessions = await services.sessionsById(id: id);
      if (sessions.isEmpty) {
        emit(SessionsNoSessions());
      } else {
        emit(SessionsLoaded(sessions: sessions));
      }
    } catch (e) {
      emit(SessionsFailed(errorMsg: e.toString()));
    }
  }
}
