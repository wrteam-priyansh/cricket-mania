import 'package:cricket_mania/data/repositories/authRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignInState extends Equatable {}

class SignInInitial extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInInProgress extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final String firebaseUId;
  //can add jwt token if needed

  SignInSuccess(this.firebaseUId);
  @override
  List<Object?> get props => [firebaseUId];
}

class SignInFailure extends SignInState {
  final String errorMessage;

  SignInFailure(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit(this.authRepository) : super(SignInInitial());

  void signInUser({required String email, required String password}) {
    emit(SignInInProgress());

    authRepository
        .signInUser(email: email, password: password)
        .then((value) => emit(SignInSuccess(value)))
        .catchError((e) => emit(SignInFailure(e.toString())));
  }
}
