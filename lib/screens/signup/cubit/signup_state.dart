part of 'signup_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  final String email;
  final String password;
  final String username;
  final SignUpStatus status;
  final Failure failure;

  const SignUpState({
    required this.email,
    required this.username,
    required this.password,
    required this.status,
    required this.failure,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      email: '',
      password: '',
      username: '',
      status: SignUpStatus.initial,
      failure: Failure(),
    );
  }

  bool get isFormValid =>
      password.isNotEmpty && email.isNotEmpty && username.isNotEmpty;

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [email, password, status, failure];

  SignUpState copyWith({
    String? email,
    String? password,
    String? username,
    SignUpStatus? status,
    Failure? failure,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
