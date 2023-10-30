// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../usecases.dart';

class UpdateUserUseCaseParams extends Equatable {
  final String userId;
  final String? userName;
  final String? avaterUrl;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId];

  const UpdateUserUseCaseParams({
    required this.userId,
    this.userName,
    this.avaterUrl,
  });
}
