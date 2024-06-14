import 'package:dartz/dartz.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/models/use_case.dart';
import 'package:kanban/features/board/data/board_task/board_task.dart';
import 'package:kanban/features/board/repository/board_repository.dart';

class GetActiveTasksUseCase extends UseCase<List<BoardTask>, String> {
  final BoardRepository _repository;

  GetActiveTasksUseCase({required BoardRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<BoardTask>>> call(String params) {
    return _repository.getActiveTasks(params);
  }
}
