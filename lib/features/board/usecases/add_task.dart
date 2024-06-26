import 'package:dartz/dartz.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/models/use_case.dart';
import 'package:kanban/features/board/data/board_task/board_task.dart';
import 'package:kanban/features/board/repository/board_repository.dart';

class CreateTaskUseCase extends UseCase<BoardTask, BoardTask> {
  final BoardRepository _repository;

  CreateTaskUseCase({required BoardRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, BoardTask>> call(BoardTask params) {
    return _repository.createTask(params);
  }
}
