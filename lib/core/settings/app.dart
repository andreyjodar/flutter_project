import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/usecases/delete_company_usecase.dart';
import 'package:flutter_project/domain/usecases/get_producers_usecase.dart';
import 'package:flutter_project/domain/usecases/register_company_usecase.dart';
import 'package:flutter_project/domain/usecases/register_product_usecase.dart';
import 'package:flutter_project/domain/usecases/update_company_usecase.dart';
import 'package:flutter_project/domain/usecases/update_product_usecase.dart';
import 'package:flutter_project/domain/usecases/update_user_usecase.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_company_dao.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_product_dao.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_user_dao.dart';
import 'package:flutter_project/domain/usecases/login_user_usecase.dart';
import 'package:flutter_project/domain/usecases/register_user_usecase.dart';
import 'package:flutter_project/infrastructure/repositories/company_repository_impl.dart';
import 'package:flutter_project/infrastructure/repositories/product_repository_impl.dart';
import 'package:flutter_project/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_project/presentation/pages/company/company_form.dart';
import 'package:flutter_project/presentation/pages/auth/login_form.dart';
import 'package:flutter_project/presentation/pages/auth/user_form.dart';
import 'package:flutter_project/presentation/pages/home/menu_pages.dart';
import 'package:flutter_project/presentation/pages/product/company_products_page.dart';
import 'package:flutter_project/presentation/pages/product/product_form.dart';
import 'package:flutter_project/presentation/pages/product/product_form_args.dart';
import 'package:flutter_project/presentation/pages/product/product_page.dart';
import 'package:flutter_project/presentation/pages/company/company_page.dart';
import 'package:flutter_project/core/settings/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: Routes.login,
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.mainPage: (context) => MenuPages(),
        Routes.login: (context) => LoginForm(loginUserUseCase: LoginUserUseCase(UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))),
        Routes.userForm: (context) => UserForm(updateUserUseCase: UpdateUserUseCase((UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), registerUserUseCase: RegisterUserUseCase(UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))),
        Routes.company: (context) => CompanyPage(initialCompany: ModalRoute.of(context)?.settings.arguments as Company, deleteCompanyUseCase: DeleteCompanyUseCase(CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Routes.companyForm: (context) => CompanyForm(existingCompany: ModalRoute.of(context)?.settings.arguments as Company?, registerCompanyUseCase: RegisterCompanyUseCase(CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance)))), updateCompanyUseCase: UpdateCompanyUseCase(CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))),
        Routes.companyProducts: (context) => CompanyProductsPage(existingCompany: ModalRoute.of(context)?.settings.arguments as Company),
        Routes.product: (context) => ProductPage(),
        Routes.productForm: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as ProductFormArgs;
          return  ProductForm(currentCompany: args.company, existingProduct: args.product, registerProductUseCase: RegisterProductUseCase(ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))), updateProductUseCase: UpdateProductUseCase(ProductRepositoryImpl(productDao: FirebaseProductDao(FirebaseFirestore.instance), companyRepository: CompanyRepositoryImpl(companyDao: FirebaseCompanyDao(FirebaseFirestore.instance), userRepository: UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))))));
        }
        // Routes.purchaseForm: (context) => PurchaseForm(),
      }
    );
  }
}
