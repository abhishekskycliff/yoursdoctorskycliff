import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_event_class.dart';

class Bloc_Counter {
  final _formKey = GlobalKey<FormState>();

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;
  final _counterEventController = StreamController<EventCounter>();

  Sink<EventCounter> get counterEventSink => _counterEventController.sink;

  Bloc_Counter() {
    _counterEventController.stream.listen((_mapEventtoState));
  }

  void _mapEventtoState(EventCounter event) {
    if (event is AuthenticateUser)
      if (_formKey.currentState.validate()) {

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => SecurityPin()),
        // );

        print("coming from Bloc class ");
      }
    else
      return null;
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}


