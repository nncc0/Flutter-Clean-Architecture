// 📍 Service Locator
import 'package:get_it/get_it.dart';
import '../network/network_info.dart';
import '../network/api_client.dart';
import '../theme/theme_cubit.dart';
import 'storage_service.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // External
  // getIt.registerLazySingleton(() => InternetConnectionChecker());
  // getIt.registerLazySingleton(() => Connectivity());
  // getIt.registerLazySingleton(() => SharedPreferences.getInstance());
  
  // Core
  // getIt.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(
  //     getIt<InternetConnectionChecker>(),
  //     getIt<Connectivity>(),
  //   ),
  // );
  
  // getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  
  // Services
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(storageService: getIt<StorageService>()));
  
}
