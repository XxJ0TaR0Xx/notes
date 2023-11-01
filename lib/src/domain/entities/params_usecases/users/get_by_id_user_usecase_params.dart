part of '../usecases.dart';

class GetByIdUseCaseParams extends Equatable {
  final String userId;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId];

  const GetByIdUseCaseParams({
    required this.userId,
  });
}
