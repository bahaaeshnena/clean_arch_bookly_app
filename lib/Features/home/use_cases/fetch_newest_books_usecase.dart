import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/repositories/home_repo.dart';
import 'package:bookly/core/use_cases_core/use_case.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/faliure.dart';

class FetchNewestBooksUseCase extends UseCase<List<BookEntity>, void> {
  final HomeRepo homeRepo;
  FetchNewestBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([void params]) async {
    return await homeRepo.fetchNewestdBooks();
  }
}
