import 'package:flutter/material.dart';
import 'package:updatable/updatable.dart';
import 'package:mow/src/observer_state.dart';

abstract class ModelWidget<Model extends Updatable> extends StatefulWidget {
  final Model _model;
  Model get model => _model;

  const ModelWidget({required Model model, Key? key})
      : _model = model,
        super(key: key);

  @override
  @factory
  @protected
  ObserverState
      createState(); // ignore: no_logic_in_create_state, this is the original sin

}
