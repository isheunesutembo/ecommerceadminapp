import 'package:ecommerceadmin/ui/productspage.dart';
import 'package:flutter/material.dart';

class HomeDashBoardWidget extends StatelessWidget {
  const HomeDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  SizedBox(
      width: double.infinity,
      height:height*0.55,
      child: GridView(
        
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            children: [
              
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsPage()));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/products.png",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    const  SizedBox(
                        height: 10,
                      ),
                  const    Text(
                        "Products",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/payments.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  const  Text(
                      "Payments",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/monitor.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                 const   Text(
                      "Analytics",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/order-delivery.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                 const   Text(
                      "Orders",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            
            ],
          ),
    );
  }
}