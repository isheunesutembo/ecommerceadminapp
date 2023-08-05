import 'package:ecommerceadmin/controllers/authcontroller.dart';
import 'package:ecommerceadmin/firebase_options.dart';
import 'package:ecommerceadmin/models/store.dart';
import 'package:ecommerceadmin/router.dart';
import 'package:ecommerceadmin/ui/home.dart';
import 'package:ecommerceadmin/ui/loginpage.dart';
import 'package:ecommerceadmin/widgets/errortext.dart';
import 'package:ecommerceadmin/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
   MyApp({super.key});
Store? storeModel;
void getData(WidgetRef ref,User data)async{
  storeModel=await ref.watch(authControllerProvider.notifier)
  .getStoreData(data.uid)
  .first;
  ref.read(storeProvider.notifier).update((state) => storeModel);
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ref.watch(authStateChangeProvider)
    .when(data:(data)=>
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser:const RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context){
          if(data!=null){
            getData(ref, data);
            return loggedInRoute;
          }
          return loggedOutRoute;
        }
        
      ),
    ), error: (error,stackTrace)=>ErrorText(error: error.toString()), loading: ()=>Loader(),
    );
  }
}
