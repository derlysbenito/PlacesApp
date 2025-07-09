import 'package:technical_test/data/datasource/user_datasource.dart';
import '../../data/models/users_response.dart';

class UserRepository {
  final UserDataSource remoteDataSource;

  UserRepository(this.remoteDataSource);

  Future<List<UsersResponse>> getUsers() {
    return remoteDataSource.fetchUsers();
  }
}
