import 'package:dartz/dartz.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/models/use_case.dart';
import 'package:kanban/features/board/data/comment/comment.dart';
import 'package:kanban/features/board/repository/board_repository.dart';

class CreateCommentUseCase extends UseCase<Comment, Comment> {
  final BoardRepository _repository;

  CreateCommentUseCase({required BoardRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Comment>> call(Comment params) {
    return _repository.createComment(params);
  }
}
