import 'package:equatable/equatable.dart';

abstract class EmailEvent extends Equatable{
  const EmailEvent();

  @override
  List<Object?> get props => [];
}

class EmailSubmitted extends EmailEvent {
  final String email;

  const EmailSubmitted({required this.email});

  @override
  List<Object?> get props => [email];
}