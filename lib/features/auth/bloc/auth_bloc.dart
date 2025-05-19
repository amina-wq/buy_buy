import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_buy/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:buy_buy/repositories/user/user_repository_interface.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserRepositoryInterface userRepository})
      : _userRepository = userRepository,
      super(AuthInitial()) {
    on<AuthCheckEvent>(_onAuthCheckEvent);
    on<AuthSignInEvent>(_onSignIn);
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthLogOutEvent>(_onLogout);
  }

  final UserRepositoryInterface _userRepository;

  void _onAuthCheckEvent(AuthCheckEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final Profile? profile = await _userRepository.getCurrentUser();
      if (profile != null) {
        emit(Authorized(profile: profile, initial: true));
      } else {
        emit(Unauthorized());
      }
    } catch (e) {
      emit(Unauthorized(error: e));
    }
  }

  void _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final Profile? profile = await _userRepository.signIn(event.email, event.password);
      if (profile != null) {
        emit(Authorized(profile: profile));
      } else {
        emit(const Unauthorized(error: 'Invalid credentials'));
      }
    } catch (e) {
      emit(Unauthorized(error: e));
    }
  }

  void _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final Profile? profile = await _userRepository.signUp(event.email, event.password, event.phone);
      if (profile != null) {
        emit(Authorized(profile: profile));
      } else {
        emit(const Unauthorized(error: 'Invalid credentials'));
      }
    } catch (e) {
      emit(Unauthorized(error: e));
    }
  }

  void _onLogout(AuthLogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _userRepository.logout();
      emit(Unauthorized());
    } catch (e) {
      emit(Unauthorized(error: e));
    }
  }

}
