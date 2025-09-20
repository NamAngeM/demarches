import 'package:dartz/dartz.dart';
import '../entities/demarche.dart';
import '../repositories/demarche_repository.dart';
import '../../core/errors/failures.dart';

class GetDemarches {
  final DemarcheRepository repository;

  GetDemarches(this.repository);

  Future<Either<Failure, List<Demarche>>> call(String userId) async {
    return await repository.getDemarches(userId);
  }
}
