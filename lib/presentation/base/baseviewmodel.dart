abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //// shared variables and functions that will be used
  ///through the any view model
}

abstract class BaseViewModelInputs {
  void start(); ///// will be called while init. of view model
  void dispose(); ///// will be called when viewmodel dies
}

abstract class BaseViewModelOutputs {}
