import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';
import 'package:flutter_project/domain/repositories/product_repository_interface.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';
import 'package:flutter_project/infrastructure/adapters/cart_adapter.dart';
import 'package:flutter_project/infrastructure/datasources/cart_dao_interface.dart';

class CartRepositoryImpl implements CartRepositoryInterface {
  final CartDaoInterface cartDao;
  final ProductRepositoryInterface productRepository;
  final UserRepositoryInterface userRepository;

  CartRepositoryImpl({required this.cartDao, required this.productRepository, required this.userRepository});

  @override
  Future<void> createCart(Cart cart) async {
    final cartDto = CartAdapter.toDto(cart);
    await cartDao.create(cartDto);
  }

  @override
  Future<void> deleteCart(String id) async {
    await cartDao.delete(id);
  }

@override
Future<Cart?> getCartById(String id) async {
  final cartDto = await cartDao.getById(id);
  if (cartDto == null) return null;

  final buyer = await userRepository.getUserById(cartDto.buyerId);
  if (buyer == null) {
    throw Exception('User ${cartDto.buyerId} not found');
  }

  final productsMap = <String, Product>{};

  for (final item in cartDto.cartItems) {
    final product = await productRepository.getProductById(item.productId);
    if (product == null) {
      throw Exception('Product ${item.productId} not found');
    }
    productsMap[item.productId] = product;
  }

  return CartAdapter.fromDto(cartDto, buyer: buyer, productsMap: productsMap);
}

@override
Future<Cart?> getActiveCartByBuyer(String buyerId) async {
  final cartDto = await cartDao.getActiveByBuyer(buyerId);
  if (cartDto == null) return null;

  final buyer = await userRepository.getUserById(cartDto.buyerId);
  if (buyer == null) {
    throw Exception('User ${cartDto.buyerId} not found');
  }

  final productsMap = <String, Product>{};

  for (final item in cartDto.cartItems) {
    final product = await productRepository.getProductById(item.productId);
    if (product == null) {
      throw Exception('Product ${item.productId} not found');
    }
    productsMap[item.productId] = product;
  }

  return CartAdapter.fromDto(cartDto, buyer: buyer, productsMap: productsMap);
}

  @override
  Future<void> updateCart(Cart cart) async {
    final cartDto = CartAdapter.toDto(cart);
    await cartDao.update(cartDto);
  }
}