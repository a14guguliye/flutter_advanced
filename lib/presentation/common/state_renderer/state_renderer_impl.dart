import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;

  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() {
    return EMPTY;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.CONTENT_SCREEN_STATE;
  }
}

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.EMPTY_SCREEN_STATE;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
          showPopUp(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
          showPopUp(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryActionFunction: retryActionFunction,
        );
      default:
        return contentScreenWidget;
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding?.instance.addPostFrameCallback((timeStamp) async {
      await showDialog(
          context: context,
          builder: (context) => StateRenderer(
                stateRendererType: stateRendererType,
                message: message,
                retryActionFunction: () {},
              ));
    });
  }
}
