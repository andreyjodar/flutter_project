import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/core/settings/app.dart';
import 'package:flutter_project/domain/usecases/add_cart_item_usecase.dart';
import 'package:flutter_project/domain/usecases/create_cart_usecase.dart';
import 'package:flutter_project/domain/usecases/delete_cart_usecase.dart';
import 'package:flutter_project/domain/usecases/get_active_cart_usecase.dart';
import 'package:flutter_project/domain/usecases/get_all_companies_usecase.dart';
import 'package:flutter_project/domain/usecases/get_companies_by_user_usecase.dart';
import 'package:flutter_project/domain/usecases/get_products_by_company_usecase.dart';
import 'package:flutter_project/domain/usecases/remove_cart_item_usecase.dart';
import 'package:flutter_project/domain/usecases/update_cart_item_usecase.dart';
import 'package:flutter_project/domain/usecases/update_cart_usecase.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_cart_dao.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_company_dao.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_product_dao.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_user_dao.dart';
import 'package:flutter_project/infrastructure/repositories/cart_repository_impl.dart';
import 'package:flutter_project/infrastructure/repositories/company_repository_impl.dart';
import 'package:flutter_project/infrastructure/repositories/product_repository_impl.dart';
import 'package:flutter_project/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_project/presentation/stores/cart_notifier.dart';
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
        Provider<GetCompaniesByUserUseCase>(create: (_) => GetCompaniesByUserUseCase(CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<GetAllCompaniesUseCase>(create: (_) => GetAllCompaniesUseCase(CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<GetProductsByCompanyUseCase>(create: (_) => GetProductsByCompanyUseCase(ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))))),
        Provider<GetActiveCartUseCase>(create: (_) => GetActiveCartUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository: ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<UpdateCartUseCase>(create: (_) => UpdateCartUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository:ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<DeleteCartUseCase>(create: (_) => DeleteCartUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository:ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<CreateCartUseCase>(create: (_) => CreateCartUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository:ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<AddCartItemUseCase>(create: (_) => AddCartItemUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository:ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<RemoveCartItemUseCase>(create: (_) => RemoveCartItemUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository:ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Provider<UpdateCartItemUseCase>(create: (_) => UpdateCartItemUseCase(CartRepositoryImpl(cartDao: FirebaseCartDao(FirebaseFirestore.instance), productRepository:ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        ChangeNotifierProvider(
          create: (context) => CartNotifier(
            createCartUseCase: context.read<CreateCartUseCase>(),
            getActiveCartUseCase: context.read<GetActiveCartUseCase>(),
            updateCartUseCase: context.read<UpdateCartUseCase>(),
            deleteCartUseCase: context.read<DeleteCartUseCase>(),
            addCartItemUseCase: context.read<AddCartItemUseCase>(),
            removeCartItemUseCase: context.read<RemoveCartItemUseCase>(),
            updateCartItemUseCase: context.read<UpdateCartItemUseCase>(),
            loggedUserStore: context.read<LoggedUserStore>(),
          ),
        ),
      ], 
      child: const App()
    ),
  );
}
