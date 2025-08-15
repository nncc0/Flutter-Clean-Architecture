// 📍 Service Locator
import 'package:get_it/get_it.dart';
import '../l10n/language_cubit.dart';
import '../network/api_client.dart';
import '../theme/theme_cubit.dart';
import 'navigation_service.dart';
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
  
   getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  

  // Services
  final storageService = StorageService();
  await storageService.init();  // Initialize storage service first
  getIt.registerLazySingleton<StorageService>(() => storageService);
  
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());

  // Register cubits after storage is initialized
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(storageService: getIt<StorageService>()));
  getIt.registerFactory<LanguageCubit>(() => LanguageCubit(storageService: getIt<StorageService>()));

  
}
