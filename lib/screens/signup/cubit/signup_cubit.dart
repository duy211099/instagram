import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_instagram/models/failure_model.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: SignUpStatus.initial));
  }

  void usernameChanged(String username) {
    emit(state.copyWith(username: username, status: SignUpStatus.initial));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, status: SignUpStatus.initial));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignUpStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository.signUpWithEmailAndPassword(
        email: state.email,
        password: state.password,
        username: state.username,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: SignUpStatus.error));
    }
  }
}
