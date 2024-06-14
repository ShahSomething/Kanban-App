import 'package:dartz/dartz.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/models/use_case.dart';
import 'package:kanban/features/board/repository/board_repository.dart';

class CloseTaskUseCase extends UseCase<void, String> {
  final BoardRepository _repository;

  CloseTaskUseCase({required BoardRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(String params) {
    return _repository.closeTask(params);
  }
}
