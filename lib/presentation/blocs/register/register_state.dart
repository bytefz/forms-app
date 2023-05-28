part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final bool isValid;
  final FormStatus formStatus;
  final Username username;
  final Email email;
  final Password password;

  const RegisterFormState({
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  RegisterFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Username? username,
    Email? email,
    Password? password,
  }) =>
      RegisterFormState(
        email: email ?? this.email,
        formStatus: formStatus ?? this.formStatus,
        password: password ?? this.password,
        username: username ?? this.username,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => [username, email, password, formStatus, isValid];
}
