// ignore_for_file: cascade_invocations

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:get_it/get_it.dart';
import 'package:kanban/core/services/network/dio_error_handler.dart';
import 'package:kanban/core/services/network/dio_wrapper.dart';
import 'package:kanban/core/services/network/network_info.dart';
import 'package:kanban/core/services/network/network_info_imp.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _initDependencies();
}

Future<void> _initDependencies() async {
  locator.registerSingleton<Connectivity>(
    Connectivity(),
  );
  locator.registerSingletonWithDependencies<INetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: locator<Connectivity>(),
    ),
    dependsOn: [
      Connectivity,
    ],
  );
  locator.registerSingleton<Logger>(
    Logger(),
  );
  locator.registerSingleton<DioErrorHandler>(
    DioErrorHandlerImpl(),
  );

  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(
          seconds: 20,
        ),
        sendTimeout: const Duration(
          seconds: 20,
        ),
        baseUrl: 'https://api.todoist.com/rest/v2', // TODO add base url
      ),
    ),
  );

  final cacheDir = await getTemporaryDirectory();
  final cacheStore = HiveCacheStore(
    cacheDir.path,
    hiveBoxName: 'kanban',
  );

  locator.registerSingletonWithDependencies<IDioWrapper>(
    () => DioWrapperImpl(
      dio: locator<Dio>(),
      dioErrorHandler: locator<DioErrorHandler>(),
      logger: locator<Logger>(),
      cacheStore: cacheStore,
    ),
    dependsOn: [
      Dio,
      DioErrorHandler,
      Logger,
    ],
  );
}

// ///Common UseCase init here
// Future<void> _initAppUseCases() async {
//   // global use cases

//   Get.lazyPut<SaveUserInformationUseCase>(
//       () => SaveUserInformationUseCase(repository: Get.find<AuthRepository>()));

//   Get.lazyPut<GetUserInformationUseCase>(
//       () => GetUserInformationUseCase(repository: Get.find<AuthRepository>()));
// }
