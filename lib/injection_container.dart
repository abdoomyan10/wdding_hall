import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';

// Home imports
import 'package:wedding_hall/features/home/domain/repositories/home_repository.dart';
import 'package:wedding_hall/features/home/domain/usecases/get_home_data_usecase.dart';
 // ✅ إزالة hide
import 'package:wedding_hall/features/home/presentation/cubit/home_cubit.dart';
import 'package:wedding_hall/core/network/network_info.dart';

import 'package:wedding_hall/features/home/data/datasources/home_local_data_source.dart';


// Payments imports - إصلاح جميع الاستيرادات
import 'package:wedding_hall/features/payments/data/datasources/payment_data_source.dart';
import 'package:wedding_hall/features/payments/data/repositories/payment_repository_impl.dart';
import 'package:wedding_hall/features/payments/domain/repositories/payment_repository.dart';

import 'package:wedding_hall/features/payments/domain/usecases/delete_payment_usecase.dart';
import 'package:wedding_hall/features/payments/domain/usecases/get_payments_stats_usecase.dart'; // ✅ إزالة hide
import 'package:wedding_hall/features/payments/domain/usecases/update_payment_usecase.dart';

import 'package:wedding_hall/features/payments/presentation/cubit/payment_cubit.dart';

import 'features/home/data/repositories/home_repsoitory_impl.dart';
import 'features/payments/domain/usecases/add_payment_usecase.dart';
import 'features/payments/domain/usecases/get_payment_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // تهيئة Firebase
  await Firebase.initializeApp();

  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Home Feature
  sl.registerLazySingleton<HomeDataSource>(() => HomeLocalDataSource());

  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      dataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));
  sl.registerLazySingleton(() => RefreshHomeDataUseCase(sl()));
  sl.registerLazySingleton(() => SearchUseCase(sl())); // ✅ إصلاح

  sl.registerFactory(() => HomeCubit(
    getHomeDataUseCase: sl(),
    refreshHomeDataUseCase: sl(),
    searchUseCase: sl(),
  ));

  // Payments Feature - التسجيل الكامل
  sl.registerLazySingleton<PaymentDataSource>(() => PaymentLocalDataSource());

  sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(
    dataSource: sl(),
    networkInfo: sl(),
  ));

  // ✅ تسجيل جميع use cases للمدفوعات
  sl.registerLazySingleton(() => GetPaymentsUseCase(sl()));
  sl.registerLazySingleton(() => AddPaymentUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePaymentUseCase(sl()));
  sl.registerLazySingleton(() => DeletePaymentUseCase(sl()));
  sl.registerLazySingleton(() => GetPaymentStatsUseCase(sl()));

  sl.registerFactory(() => PaymentCubit(
    getPaymentsUseCase: sl(),
    addPaymentUseCase: sl(),
    updatePaymentUseCase: sl(),
    deletePaymentUseCase: sl(),
    getPaymentStatsUseCase: sl(),
  ));
}