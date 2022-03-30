part of 'profile_bloc.dart';

enum ProfileStatus { init, loading, loaded, error }

class ProfileState extends Equatable {
  final User user;
  // final List<Post> post;
  final bool isCurrentUser;
  final bool isGridView;
  final bool isFollowing;
  final ProfileStatus status;
  final Failure failure;

  const ProfileState({
    required this.user,
    required this.isCurrentUser,
    required this.isGridView,
    required this.isFollowing,
    required this.status,
    required this.failure,
  });

  factory ProfileState.initial() => const ProfileState(
        user: User.empty,
        isCurrentUser: false,
        isFollowing: false,
        isGridView: false,
        status: ProfileStatus.init,
        failure: Failure(),
      );

  @override
  List<Object> get props =>
      [user, isCurrentUser, isFollowing, isGridView, status, failure];

  ProfileState copyWith({
    User? user,
    bool? isCurrentUser,
    bool? isGridView,
    bool? isFollowing,
    ProfileStatus? status,
    Failure? failure,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isGridView: isGridView ?? this.isGridView,
      isFollowing: isFollowing ?? this.isFollowing,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
