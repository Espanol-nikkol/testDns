

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_dns/formExtra.dart';
import 'package:test_dns/userModel.dart';

class FormPersonal extends StatefulWidget {
  final UserModel _model;

  FormPersonal(this._model);

  @override
  State<StatefulWidget> createState() => _FormPersonalState(_model);
}

class _FormPersonalState extends State<FormPersonal> {
  UserModel model;

  _FormPersonalState(this.model);

  final _formKey = GlobalKey<FormState>();
  final _allowedTextSymbols = new RegExp("^[a-zA-Zа-яА-ЯёЁ][a-zA-Zа-яА-ЯёЁ]*\$");
  final _allowedEmail = new RegExp(r"^\w+@\w+\.\w+$");
  final _allowedPhone = new RegExp(r"^[8]\d{10}$");

  String _firstName = "",
      _lastName = "",
      _patronymic = "",
      _phone = "",
      _email = "";

  String onValidateText(String value) =>
      _allowedTextSymbols.hasMatch(value.trim()) ?
          null :
          "Пожалуйста, используйте только кириллицу, латиницу и _";

  String onValidateEmail(String value) => _allowedEmail.hasMatch(value.trim()) ?
    null :
    "Формат e-mail: xxx@xxx.xx";

  String onValidatePhone(String value) => _allowedPhone.hasMatch(value.trim()) ?
    null :
    "Формат номера телефона: 8XXXXXXXXXX";

  _insets() => const EdgeInsets.only(left: 15.0, right: 15.0);
  _textStyle() => const TextStyle(
    height: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: this._insets(),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Имя",
                      ),
                      style: this._textStyle(),
                      validator: (value) => this.onValidateText(value),
                      onSaved: (v) {
                        _firstName = v.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: this._insets(),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Фамилия"
                      ),
                      validator: (value) => this.onValidateText(value),
                      onSaved: (v) {
                        _lastName = v.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: this._insets(),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Отчество"
                      ),
                      validator: (value) => this.onValidateText(value),
                      onSaved: (v) {
                        _patronymic = v.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: this._insets(),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "E-mail"
                      ),
                      validator: (value) => onValidateEmail(value),
                      onSaved: (v) {
                        _email = v.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: this._insets(),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Телефон"
                      ),
                      validator: (value) => onValidatePhone(value),
                      onSaved: (v) {
                        _phone = v.trim();
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 45.0),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                ),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        model.setPersonalData(
                            _firstName,
                            _lastName,
                            _patronymic,
                            _phone,
                            _email
                        );
                          model.getToken().then((evt) =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormExtra(this.model)
                                  )
                              )
                          ).catchError((error) =>
                              Scaffold.
                              of(context).
                              showSnackBar(
                                  SnackBar(
                                    content: Text(error.message),
                                    backgroundColor: Colors.red,
                                  )
                              )
                          );
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Проверьте введенные значения'), backgroundColor: Colors.red,));
                      }
                    },
                    textColor: Colors.white,
                    color: Color.fromRGBO(237,142,0,1),
                    child: Text("Получить ключ")
                    ),
                  ),
                ),
            ]
        )
    );
  }
}
