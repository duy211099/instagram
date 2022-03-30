import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_instagram/blocs/auth/auth_bloc.dart';
import 'package:flutter_instagram/repositories/repositories.dart';

import '../../../models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;

  ProfileBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
  })  : _userRepository = userRepository,
        _authBloc = authBloc,
        super(ProfileState.initial()) {
    on<ProfileLoadUser>((event, emit) async {
      emit(state.copyWith(status: ProfileStatus.loading));

      try {
        final user = await _userRepository.getUserWithId(event.userId);
        final isCurrentUser = _authBloc.state.user?.uid == user.id;

        emit(state.copyWith(
          user: user,
          isCurrentUser: isCurrentUser,
          status: ProfileStatus.loaded,
        ));
      } catch (err) {
        emit(state.copyWith(
            status: ProfileStatus.error,
            failure: const Failure(
              message: 'We are unable to load this profile.',
            )));
      }
    });
  }
}
