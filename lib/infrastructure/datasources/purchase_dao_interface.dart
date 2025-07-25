import 'package:flutter_project/infrastructure/models/purchase_dto.dart';

abstract class PurchaseDaoInterface {
  Future<PurchaseDto?> getById(String id);
  Future<PurchaseDto?> getByCart(String cartId);
  Future<List<PurchaseDto>> getByBuyer(String cartId);
  Future<List<PurchaseDto>> getBySeller(String companyId);
  Future<void> create(PurchaseDto purchaseDto);
  Future<void> update(PurchaseDto purchaseDto);
  Future<void> delete(String purchaseId);
}