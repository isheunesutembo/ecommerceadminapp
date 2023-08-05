import 'package:ecommerceadmin/ui/home.dart';
import 'package:ecommerceadmin/ui/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute=RouteMap(routes: {
  '/':(_)=>MaterialPage(child: LogInPage())
});
final loggedInRoute=RouteMap(routes: {
  '/':(_)=>MaterialPage(child: Home())
});

