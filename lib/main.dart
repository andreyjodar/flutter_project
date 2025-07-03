import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/core/settings/app.dart';
import 'package:flutter_project/domain/usecases/get_all_companies_usecase.dart';
import 'package:flutter_project/domain/usecases/get_companies_by_user_usecase.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_company_dao.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_user_dao.dart';
import 'package:flutter_project/infrastructure/repositories/company_repository_impl.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:provider/provider.dart';
import "core/firebase/firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoggedUserStore()),
        Provider<GetCompaniesByUserUseCase>(create: (_) => GetCompaniesByUserUseCase(CompanyRepositoryImpl(userDao: FirebaseUserDao(FirebaseFirestore.instance), companyDao: FirebaseCompanyDao(FirebaseFirestore.instance)))),
        Provider<GetAllCompaniesUseCase>(create: (_) => GetAllCompaniesUseCase(CompanyRepositoryImpl(userDao: FirebaseUserDao(FirebaseFirestore.instance), companyDao: FirebaseCompanyDao(FirebaseFirestore.instance))))
      ], 
      child: const App()
    ),
  );
}
