import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogout implements UseCase<String, NoParams> {
  final AuthRepository authRepository;
  UserLogout(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
