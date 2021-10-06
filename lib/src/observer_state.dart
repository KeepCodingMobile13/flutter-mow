import 'package:flutter/material.dart';
import 'package:mow/src/model_widget.dart';
import 'package:updatable/updatable.dart';

abstract class ObserverState<Model extends Updatable,
    W extends ModelWidget<Model>> extends State<W> {
  @mustCallSuper
  void _modelDidChange() {
    setState(() {});
  }

  /// Life cycle
  @override
  void initState() {
    // Start observing the model
    widget.model.addObserver(_modelDidChange);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant W oldWidget) {
    // stop observing old model
    oldWidget.model.removeObserver(_modelDidChange);

    // Get new model and start observing
    widget.model.addObserver(_modelDidChange);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.model.removeObserver(_modelDidChange);
    super.dispose();
  }
}
