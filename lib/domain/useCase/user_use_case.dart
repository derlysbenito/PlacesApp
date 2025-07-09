import '../../data/models/users_response.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<List<UsersResponse>> execute() {
    return repository.getUsers();
  }
}
