import "package:complete_advanced_flutter/presentation/login/login_viewmodel.dart";
import "package:complete_advanced_flutter/presentation/resources/strings_manager.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../resources/assets_manager.dart";
import "../resources/color_manager.dart";
import "../resources/values_manager.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = LoginViewModel(null);

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
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
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
                          return ElevatedButton(
                              onPressed: snapshot.data ?? false
                                  ? () {
                                      _viewModel.login();
                                    }
                                  : null,
                              child: const Text(AppStrings.login));
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
    return _getContentWidget();
  }
}
