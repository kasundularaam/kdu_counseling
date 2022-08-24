part of 'sessions_cubit.dart';

abstract class SessionsState {}

class SessionsInitial extends SessionsState {}

class SessionsLoading extends SessionsState {}

class SessionsLoaded extends SessionsState {
  final List<ChatSession> sessions;
  SessionsLoaded({
    required this.sessions,
  });
}

class SessionsNoSessions extends SessionsState {}

class SessionsFailed extends SessionsState {
  final String errorMsg;
  SessionsFailed({
    required this.errorMsg,
  });
}
