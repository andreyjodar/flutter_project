import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/get_all_companies_usecase.dart';
import 'package:flutter_project/domain/usecases/get_companies_by_user_usecase.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  late final GetCompaniesByUserUseCase _getCompaniesByUserUseCase;
  late final GetAllCompaniesUseCase _getAllCompaniesUseCase;
  List<Company> _companies = [];
  bool _isLoading = true;
  bool _isProducer = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCompaniesByUserUseCase = Provider.of<GetCompaniesByUserUseCase>(context);
    _getAllCompaniesUseCase = Provider.of<GetAllCompaniesUseCase>(context);
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    try {
      final user = Provider.of<LoggedUserStore>(context, listen: false).user;
      if (user == null) {
        setState(() {
          _isLoading = false;
        });
        return; 
      }

      if (user.type == UserType.producer) {
        _isProducer = true;
        final companies = await _getCompaniesByUserUseCase.call(user.id);
        setState(() {
          _companies = companies;
          _isLoading = false;
        });
      } else {
        _isProducer = false;
        final companies = await _getAllCompaniesUseCase.call();  // Carrega todas as empresas para 'buyer'
        setState(() {
          _companies = companies;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar empresas: $e')));
    }
  }

  void _goToCompanyDetails(Company company) {
    Navigator.pushNamed(context, Routes.company, arguments: company).then((_) {
      _loadCompanies();
    });
  }

  void _goToCreateCompany() {
    Navigator.pushNamed(context, Routes.companyForm).then((_) {
      _loadCompanies(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Center(
              child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _companies.isEmpty
                  ? const Center(child: Text('Você não possui empresas'))
                  : ListView.builder(
                      itemCount: _companies.length,
                      itemBuilder: (context, index) {
                        final company = _companies[index];
                        return Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black12, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leading: const Icon(Icons.store),
                              title: Text(company.name),
                              subtitle: Text(company.cnpj),
                              onTap: () => _goToCompanyDetails(company), 
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
              ),
          )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: _isProducer ? SubmitButton(
            onPressed: _goToCreateCompany, 
            text: 'Criar Empresa'
          ) : SizedBox.shrink(),
        ),
      ),
    );
  }
}
