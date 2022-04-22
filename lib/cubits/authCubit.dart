import 'package:cricket_mania/data/models/auth.dart';
import 'package:cricket_mania/data/repositories/authRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final Auth auth;

  Authenticated(this.auth);

  @override
  List<Object?> get props => [auth];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial()) {
    _checkIsAuthenticated();
  }

  Auth getAuthDetails() {
    if (state is Authenticated) {
      return (state as Authenticated).auth;
    }
    return Auth(firebaseUId: "", jwtToken: "");
  }

  void _checkIsAuthenticated() {
    if (authRepository.getIsLogIn()) {
      emit(Authenticated(Auth(
          firebaseUId: authRepository.getFirebaseUId(), jwtToken: "JWTTOKEN")));
    } else {
      emit(Unauthenticated());
    }
  }

  void authenticateUser(
      {required String firebaseUId, required String jwtToken}) {
    //
    authRepository.setFirebaseUId(firebaseUId);
    authRepository.setIsLogIn(true);
    //emit new state
    emit(Authenticated(Auth(firebaseUId: firebaseUId, jwtToken: jwtToken)));
  }

  void signOut() {
    authRepository.signOutUser();
    emit(Unauthenticated());
  }
}
