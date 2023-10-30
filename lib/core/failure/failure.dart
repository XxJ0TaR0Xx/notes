// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;

  const Failure({
    required this.message,
  });
}
