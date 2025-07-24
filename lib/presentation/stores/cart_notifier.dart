import 'package:flutter/material.dart';
import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/entities/cart_item.dart';
import 'package:flutter_project/domain/usecases/add_cart_item_usecase.dart';
import 'package:flutter_project/domain/usecases/create_cart_usecase.dart';
import 'package:flutter_project/domain/usecases/delete_cart_usecase.dart';
import 'package:flutter_project/domain/usecases/get_active_cart_usecase.dart';
import 'package:flutter_project/domain/usecases/remove_cart_item_usecase.dart';
import 'package:flutter_project/domain/usecases/update_cart_item_usecase.dart';
import 'package:flutter_project/domain/usecases/update_cart_usecase.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:uuid/uuid.dart';

class CartNotifier extends ChangeNotifier {
  final LoggedUserStore loggedUserStore;
  Cart? _cart;

  final CreateCartUseCase createCartUseCase;
  final GetActiveCartUseCase getActiveCartUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;
  final AddCartItemUseCase addCartItemUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final UpdateCartItemUseCase updateCartItemUseCase;

  CartNotifier({
    required this.createCartUseCase,
    required this.getActiveCartUseCase,
    required this.updateCartUseCase,
    required this.deleteCartUseCase,
    required this.addCartItemUseCase,
    required this.removeCartItemUseCase,
    required this.updateCartItemUseCase,
    required this.loggedUserStore
  });

  Cart? get cart => _cart;

  Future<void> loadCart() async {
    final buyer = loggedUserStore.user;
    if (buyer == null) throw Exception('Usuário não está logado');
    if (!buyer.isBuyer()) throw Exception('Usuário não é do tipo comprador');
    _cart = await getActiveCartUseCase(buyer.id);
    if (_cart == null) {
      Cart newCart = Cart(id: Uuid().v4(), buyer: buyer);
      await createCartUseCase(newCart);
      _cart = newCart;
    }
    notifyListeners();
  }

  Future<void> inactiveCart() async {
    if(_cart != null) {
      _cart!.inactiveCart();
      await updateCartUseCase(_cart!);
    }
  }

  Future<void> addItem(CartItem item) async {
    if (_cart == null) {
      loadCart();
    }
    await addCartItemUseCase.execute(_cart!, item);
    notifyListeners();
  }

  Future<void> removeItem(String itemId) async {
    if (_cart == null) return;
    await removeCartItemUseCase.execute(_cart!, itemId);
    notifyListeners();
  }

  Future<void> updateItem(String itemId, int quantity) async {
    if (_cart == null) return;
    await updateCartItemUseCase.execute(_cart!, itemId, quantity);
    notifyListeners();
  }

  double get totalPrice => _cart?.totalPrice ?? 0.0;
}
