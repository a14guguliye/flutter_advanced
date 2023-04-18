import "package:complete_advanced_flutter/presentation/onboarding/onboarding_viewmodel.dart";
import "package:complete_advanced_flutter/presentation/resources/assets_manager.dart";
import "package:complete_advanced_flutter/presentation/resources/color_manager.dart";
import "package:complete_advanced_flutter/presentation/resources/strings_manager.dart";
import "package:complete_advanced_flutter/presentation/resources/values_manager.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/svg.dart";

import "../resources/routes_manager.dart";

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  void _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  // late final List<SliderObject> _list = _getSliderData();

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    }

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(sliderViewObject.sliderObject);
          }),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.skip,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleSmall,
                    ))),

            /////adding layout for bottom .....
            _getBottomIconWidget(sliderViewObject),
          ],
        ),
      ),
    );
  }

  Widget _getBottomIconWidget(SliderViewObject? sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                //// go to next slide
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < sliderViewObject!.numOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i, sliderViewObject.currentIndex),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                //// go to next slide
                _pageController.animateToPage(_viewModel.goNext(),
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    }

    return SvgPicture.asset(ImageAssets.solidCircleIc);
  }
}

// ignore: must_be_immutable
class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;
  OnBoardingPage(
    this._sliderObject, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(
      {required this.title, required this.subTitle, required this.image});
}
