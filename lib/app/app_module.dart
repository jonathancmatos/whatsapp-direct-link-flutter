import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppModule extends Module{
  
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => Container())
  ];

}
