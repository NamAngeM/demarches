import 'package:dartz/dartz.dart';
import '../entities/demarche.dart';
import '../../core/errors/failures.dart';

abstract class DemarcheRepository {
  Future<Either<Failure, List<Demarche>>> getDemarches(String userId);
  Future<Either<Failure, Demarche>> getDemarcheById(String id);
  Future<Either<Failure, Demarche>> createDemarche(Demarche demarche);
  Future<Either<Failure, Demarche>> updateDemarche(Demarche demarche);
  Future<Either<Failure, void>> deleteDemarche(String id);
  Future<Either<Failure, List<Demarche>>> getDemarchesByStatus(
    String userId,
    DemarcheStatus status,
  );
}
