part of '../usecases.dart';

class CreateUserUseCaseParams extends Equatable {
  final String userId;
  final String userName;
  final String? avatarUrl;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [];

  const CreateUserUseCaseParams({
    required this.userId,
    required this.userName,
    this.avatarUrl,
  });
}
