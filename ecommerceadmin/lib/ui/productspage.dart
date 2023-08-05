import 'package:ecommerceadmin/controllers/productcontroller.dart';
import 'package:ecommerceadmin/ui/addproductspage.dart';
import 'package:ecommerceadmin/ui/editproductspage.dart';
import 'package:ecommerceadmin/widgets/errortext.dart';
import 'package:ecommerceadmin/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(getProductsProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        title: const Text("My Products",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductPage()));
            },
            child: const Row(
              children: [
                Text(
                  "Add Product",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 25,
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: products.when(
            data: (data) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3),
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProductPage(),
                                  settings:
                                      RouteSettings(arguments: data[index])));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 1,
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Image.network(
                                      data[index].image!,
                                      fit: BoxFit.fitHeight,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                        top: 5,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(productsControllerProvider
                                                    .notifier)
                                                .deleteProduct(
                                                    data[index]
                                                        .productId
                                                        .toString(),
                                                    context);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.delete,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )),
                                       Positioned(child:  Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.edit,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),)
                                  ],
                                ),
                                Center(
                                    child: Text(
                                  data[index].name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${data[index].price}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "\$${data[index].oldPrice}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => Loader()),
      ),
    );
  }
}
