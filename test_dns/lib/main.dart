import 'package:flutter/material.dart';
import 'package:test_dns/formExtra.dart';
import 'package:test_dns/formPersonal.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:test_dns/userModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color =
    {
      50:Color.fromRGBO(237, 142, 0, .1),
      100:Color.fromRGBO(237, 142, 0, .2),
      200:Color.fromRGBO(237, 142, 0, .3),
      300:Color.fromRGBO(237, 142, 0, .4),
      400:Color.fromRGBO(237, 142, 0, .5),
      500:Color.fromRGBO(237, 142, 0, .6),
      600:Color.fromRGBO(237, 142, 0, .7),
      700:Color.fromRGBO(237, 142, 0, .8),
      800:Color.fromRGBO(237, 142, 0, .9),
      900:Color.fromRGBO(237, 142, 0, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xffed8e00, color);

    return MaterialApp(
      title: 'Test task for DNS Kolganov NA',
      theme: ThemeData(
        primarySwatch: colorCustom,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'The best test task'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
            builder: (context, child, UserModel model) =>
                Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 4.0
                          ),
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4.0),
                              blurRadius: 4.0
                          )
                        ]
                      ),
                      child: AppBar(
                        title: Text("Ввод данных"),
                      ),
                    ),
                  ),
                  body: FormPersonal(model)
              ),
        )
    );
  }
}

