import 'package:flutter_project/domain/entities/purchase.dart';

abstract class PurchaseRepositoryInterface {
  Future<Purchase?> getPurchaseById(String id);
  Future<Purchase?> getPurchaseByCart(String cartId);
  Future<List<Purchase>> getPurchasesByBuyer(String buyerId);
  Future<List<Purchase>> getPurchasesBySeller(String companyId);
  Future<void> createPurchase(Purchase purchase);
  Future<void> updatePurchase(Purchase purchase);
  Future<void> deletePurchase(String purchaseId);
}