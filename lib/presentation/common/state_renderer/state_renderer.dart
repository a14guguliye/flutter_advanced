import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

import '../../../data/network/failure.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';

enum StateRendererType {
  ///POP UP states

  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  ///full screen states;
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, //// THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;

  String message;
  String title;
  Function? retryActionFunction;
  StateRenderer({
    super.key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? EMPTY;
  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getRetryButton(
              buttonTitle: AppStrings.ok,
              stateRendererType: StateRendererType.POPUP_ERROR_STATE,
              context: context)
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(children: [
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message: message)
        ]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn(children: [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message: message),
          _getRetryButton(
            buttonTitle: AppStrings.retry_again,
            stateRendererType: stateRendererType,
            context: context,
          )
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(children: [
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message: message)
        ]);
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s14))),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        child: _getDialogContent(context, children),
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
      ),
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage({required String message}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(
      {required String buttonTitle,
      required StateRendererType stateRendererType,
      required BuildContext context}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFunction?.call();
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn({required List<Widget> children}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
