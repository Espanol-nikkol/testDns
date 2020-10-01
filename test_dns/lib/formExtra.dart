import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_dns/userModel.dart';

class FormExtra extends StatefulWidget {
  final UserModel _model;

  FormExtra(this._model);

  @override
  State<StatefulWidget> createState() => _FormExtraState(_model);
}

class _FormExtraState extends State<FormExtra> {
  UserModel model;

  _FormExtraState(this.model);

  final _formKey = GlobalKey<FormState>();
  final _allowedUrlGit = new RegExp(r"https://github.com/.+");

  String _github, _summary;

  String onValidateUrlGit(value) => _allowedUrlGit.hasMatch(value.trim()) ?
  null :
  "Формат ссылки: https://github.com/name_profile";

  _insets() => EdgeInsets.only(left: 15.0, right: 15.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text("Отправка данных"),
          ),
        ),
      ),
      body: Form(
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
                          hintText: "Ссылка на github"
                      ),
                      validator: (value) => onValidateUrlGit(value),
                      onSaved: (v) {
                        _github = v.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: this._insets(),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Ссылка на резюме"
                      ),
                      onSaved: (v) {
                        _summary = v;
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
                            model.setWorkData(
                                _github,
                                _summary
                            );
                            model.reg().then((evt) => Navigator.pop(context)).
                            catchError((error) =>
                                Scaffold.
                                of(context).
                                showSnackBar(
                                    SnackBar(
                                      content: Text(error.message),
                                      backgroundColor: Colors.red,
                                    )
                                )
                            );
                          }
                        },
                        textColor: Colors.white,
                        color: Color.fromRGBO(237,142,0,1),
                        child: Text("Зарегистрироваться"),
                      )
                  )
              )
            ],
          )
      ),
    );
  }
}