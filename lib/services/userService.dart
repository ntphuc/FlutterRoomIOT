class UserService {
  const UserService._internal();
  static final UserService _instance = UserService._internal();
  factory UserService.instance() => _instance;
}
