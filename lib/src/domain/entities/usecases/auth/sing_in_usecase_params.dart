import 'package:equatable/equatable.dart';

class SingInUseCaseParams extends Equatable {
  final String email;
  final String password;

  const SingInUseCaseParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email];
}
