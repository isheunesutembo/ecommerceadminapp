import 'dart:io';

import 'package:ecommerceadmin/models/product.dart';
import 'package:ecommerceadmin/services/productservice.dart';
import 'package:ecommerceadmin/services/storageservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final productsControllerProvider =
    StateNotifierProvider<ProductController, bool>((ref) {
  final productsService = ref.watch(productsServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return ProductController(
      productService: productsService,
      ref: ref,
      storageService: storageService);
});

final getProductsProvider = StreamProvider(
    (ref) => ref.watch(productsControllerProvider.notifier).getProducts());

class ProductController extends StateNotifier<bool> {
  final ProductService _productService;
  final Ref _ref;
  final StorageService _storageService;
  ProductController(
      {required ProductService productService,
      required Ref ref,
      required StorageService storageService})
      : _productService = productService,
        _ref = ref,
        _storageService = storageService,
        super(false);

  Stream<List<Product>> getProducts() {
    return _productService.getProducts();
  }

  void createProduct(
      BuildContext context,
      File? file,
      String name,
      String description,
      double price,
      double oldprice,
      String categoryname) async {
    String productId = const Uuid().v1();
    final imageRes = await _storageService.storeFile(
      path: "products/",
      id: productId,
      file: file,
    );

    imageRes.fold(
        (l) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.message))), (r) async {
      final product = Product(
          productId: productId,
          image: r.toString(),
          name: name,
          description: description,
          price: price,
          oldPrice: oldprice,
          categoryname: categoryname);
      final res = await _productService.addProduct(product);
      state = false;
      res.fold(
          (l) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.message))), (r) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product uploaded successfully")));
      });
    });
  }

  void deleteProduct(String productId, BuildContext context) async {
    final res = await _productService.deleteProduct(productId);
    res.fold(
        (l) => null,
        (r) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product deleted successfully"))));
  }

  void updateProduct(BuildContext context, File? file, String name,
      String description, double price, double oldprice) async {
    String productId = Uuid().v1();
    final imageRes = await _storageService.storeFile(
      path: "products/",
      id: productId,
      file: file,
    );

    imageRes.fold((l) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product updated successfully"))), (r) async {
      final product =Product(productId: productId,image:r.toString(),
          name: name,description: description,price: price,oldPrice: oldprice );
      final res=await _productService.updateProduct(product);
      state=false;
      res.fold((l) => ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(l.toString()))), (r) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product updated successfully")));

      });
    });


  }
}
