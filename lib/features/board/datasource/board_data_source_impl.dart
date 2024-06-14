import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/services/network/api_path.dart';
import 'package:kanban/core/services/network/dio_wrapper.dart';
import 'package:kanban/features/board/data/board_task/board_task.dart';
import 'package:kanban/features/board/data/comment/comment.dart';
import 'package:kanban/features/board/data/section/section.dart';
import 'package:kanban/features/board/datasource/board_data_source.dart';

class BoardDataSourceImpl implements BoardDataSource {
  final IDioWrapper _dio;
  BoardDataSourceImpl({required IDioWrapper dio}) : _dio = dio;

  @override
  Future<void> closeTask(String taskId) async {
    final response = await _dio.onPost(api: '/tasks/$taskId/close');
    if (response.statusCode != 204) {
      throw ServerFailure(response.statusMessage ?? "Something went wrong");
    }
  }

  @override
  Future<Comment> createComment(Comment comment) async {
    final response = await _dio.onPost(
      api: APIPaths.comments,
      data: comment.toMap(),
    );
    if (response.data != null) {
      return Comment.fromMap(response.data as Map<String, dynamic>);
    }
    throw ServerFailure(response.statusMessage ?? "Something went wrong");
  }

  @override
  Future<BoardTask> createTask(BoardTask task) async {
    final response = await _dio.onPost(
      api: APIPaths.tasks,
      data: task.toMap(),
    );
    if (response.data != null) {
      return BoardTask.fromMap(response.data as Map<String, dynamic>);
    }
    throw ServerFailure(response.statusMessage ?? "Something went wrong");
  }

  @override
  Future<List<BoardTask>> getActiveTasks(String projectId) async {
    final response = await _dio.onGet(api: "${APIPaths.tasks}/$projectId");
    if (response.data != null) {
      final List<dynamic> tasks = response.data as List<dynamic>;
      return tasks
          .map((e) => BoardTask.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(response.statusMessage ?? "Something went wrong");
  }

  @override
  Future<List<Comment>> getAllComments(String taskId) async {
    final response = await _dio.onGet(
      api: APIPaths.comments,
      queryParameters: {
        'task_id': taskId,
      },
    );
    if (response.data != null) {
      final List<dynamic> comments = response.data as List<dynamic>;
      return comments
          .map((e) => Comment.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(response.statusMessage ?? "Something went wrong");
  }

  @override
  Future<List<Section>> getAllSections(String projectId) async {
    final response = await _dio.onGet(
      api: APIPaths.sections,
      queryParameters: {
        'project_id': projectId,
      },
    );
    if (response.data != null) {
      final List<dynamic> sections = response.data as List<dynamic>;
      return sections
          .map((e) => Section.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(response.statusMessage ?? "Something went wrong");
  }

  @override
  Future<void> updateComment(String commentId, String content) async {
    final response = await _dio.onPost(
      api: "${APIPaths.comments}/$commentId",
      data: {
        'content': content,
      },
    );
    if (response.statusCode != 200) {
      throw ServerFailure(response.statusMessage ?? "Something went wrong");
    }
  }

  @override
  Future<BoardTask> updateTask(
      String taskId, Map<String, dynamic> params) async {
    final response = await _dio.onPost(
      api: "${APIPaths.tasks}/$taskId",
      data: params,
    );
    if (response.data != null) {
      return BoardTask.fromMap(response.data as Map<String, dynamic>);
    }
    throw ServerFailure(response.statusMessage ?? "Something went wrong");
  }
}
