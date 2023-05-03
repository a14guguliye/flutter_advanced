import "package:complete_advanced_flutter/app/app_pref.dart";
import "package:complete_advanced_flutter/app/di.dart";
import "package:complete_advanced_flutter/data/repository/repository_implementer.dart";
import 'package:complete_advanced_flutter/data/repository/repository.dart';
import "package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart";
import "package:complete_advanced_flutter/presentation/login/login_viewmodel.dart";
import "package:complete_advanced_flutter/presentation/resources/routes_manager.dart";
import "package:complete_advanced_flutter/presentation/resources/strings_manager.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_svg/svg.dart";

import "../../domain/usecase/login_usecase.dart";
import "../resources/assets_manager.dart";
import "../resources/color_manager.dart";
import "../resources/values_manager.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPreferences appPreferences = instance<AppPreferences>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() {
      _viewModel.setUserName(username: _usernameController.text);
    });

    _passwordController.addListener(() {
      _viewModel.setPassword(password: _passwordController.text);
    });

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        appPreferences.setUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(ImageAssets.loginIc),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder(
                      stream: _viewModel.outputIsUsernameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.usernameError),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder(
                      stream: _viewModel.outputIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.passwordError),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      initialData: false,
                      stream: _viewModel.outputIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: snapshot.data ?? false
                                  ? () {
                                      _viewModel.login();
                                    }
                                  : null,
                              child: const Text(AppStrings.login)),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.forgotPasswordRoute);
                            },
                            child: Text(
                              AppStrings.forgetPassword,
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleSmall,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.registerRoute);
                            },
                            child: Text(
                              AppStrings.registerText,
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleSmall,
                            )),
                      ]),
                )
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          initialData: ContentState(),
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.login();
                }) ??
                Container();
          }),
    );
  }
}
