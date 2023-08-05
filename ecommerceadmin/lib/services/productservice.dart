import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadmin/constants/firebaseconstants.dart';
import 'package:ecommerceadmin/core/failure.dart';
import 'package:ecommerceadmin/core/type_defs.dart';
import 'package:ecommerceadmin/models/product.dart';
import 'package:ecommerceadmin/providers/firebaseproviders.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final productsServiceProvider = Provider((ref) {
  return ProductService(fireStore: ref.watch(firebaseFirestoreProvider));
});

class ProductService {
  final FirebaseFirestore _fireStore;
  ProductService({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;
  CollectionReference get _products =>
      _fireStore.collection(FirebaseConstants.productsCollection);

  Stream<List<Product>> getProducts() {
    return _products.snapshots().map((event) {
      List<Product> products = [];

      for (var doc in event.docs) {
        products.add(Product.fromJson(doc.data() as Map<String, dynamic>));
      }

      return products;
    });
  }

  Stream<Product> getProductById(String productId) {
    return _products.doc(productId).snapshots().map(
        (event) => Product.fromJson((event.data() as Map<String, dynamic>)));
  }

  Either<dynamic, Future<void>> addProduct(Product product) {
    try {
      return right(
          _products.doc(product.productId.toString()).set(product.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Either<dynamic, Future<void>> updateProduct(Product product) {
    try {
      return right(
          _products.doc(product.productId.toString()).update(product.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
   FutureVoid deleteProduct(String productId)async{
    try {
      return right(_products.doc(productId).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
   
}
