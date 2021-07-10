class Repository {
  const Repository._internal();
  static final Repository _instance = Repository._internal();
  factory Repository.instance() => _instance;
}
