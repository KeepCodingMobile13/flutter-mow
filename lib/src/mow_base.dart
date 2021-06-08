import 'package:flutter/material.dart';
import 'package:updatable/updatable.dart';

abstract class ModelIdWidget<ModelId> extends StatefulWidget {
  final ModelId _modelId;
  ModelId get modelId => _modelId;

  const ModelIdWidget({required ModelId modelId, Key? key})
      : _modelId = modelId,
        super(key: key);

  @override
  @factory
  @protected
  StateObserver
      createState(); // ignore: no_logic_in_create_state, this is the original sin

}

abstract class StateObserver<ModelId, Model extends Updatable,
    W extends ModelIdWidget<ModelId>> extends State<W> {
  @protected
  late Model model;

  @mustCallSuper
  void _modelDidChange() {
    setState(() {});
  }

  /// Obtain the model from the id stored in the Widget
  Model refreshModel(ModelId modelId);

  /// Life cycle
  @override
  void initState() {
    super.initState();

    // Obtain the model
    model = refreshModel(widget.modelId);

    // Start observing it
    model.addObserver(_modelDidChange);
  }

  @override
  void didUpdateWidget(covariant W oldWidget) {
    super.didUpdateWidget(oldWidget);

    model.removeObserver(_modelDidChange);
    model = refreshModel(widget.modelId);
    model.addObserver(_modelDidChange);
  }

  @override
  void dispose() {
    super.dispose();
    model.removeObserver(_modelDidChange);
  }
}
