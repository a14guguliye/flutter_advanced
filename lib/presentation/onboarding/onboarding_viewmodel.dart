import 'dart:async';

import 'package:complete_advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:complete_advanced_flutter/presentation/onboarding/onboarding.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = _getSliderData();

    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  @override
  int goPrevious() {
    int nextIndex = _currentIndex--;
    if (nextIndex <= -1) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() {
    return [
      SliderObject(
          title: AppStrings.onBoardingTitle1,
          subTitle: AppStrings.onBoardingSubTitle1,
          image: ImageAssets.onboardingLogo1),
      SliderObject(
          title: AppStrings.onBoardingTitle2,
          subTitle: AppStrings.onBoardingSubTitle2,
          image: ImageAssets.onboardingLogo2),
      SliderObject(
          title: AppStrings.onBoardingTitle3,
          subTitle: AppStrings.onBoardingSubTitle3,
          image: ImageAssets.onboardingLogo3),
      SliderObject(
          title: AppStrings.onBoardingTitle4,
          subTitle: AppStrings.onBoardingSubTitle4,
          image: ImageAssets.onboardingLogo4),
    ];
  }

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        sliderObject: _list[_currentIndex],
        numOfSlides: _list.length,
        currentIndex: _currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();

  void goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(
      {required this.sliderObject,
      required this.numOfSlides,
      required this.currentIndex});
}
