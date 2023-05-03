import 'dart:async';

import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //// shared variables and functions that will be used
  ///through the any view model
  ///
  final StreamController<FlowState> _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink<FlowState> get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); ///// will be called while init. of view model
  void dispose(); //
  /// will be called when viewmodel dies

  Sink<FlowState> get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
