import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:purity/config/routes/app_navigator.dart';
import 'package:purity/core/widgets/app_dialogs.dart';
import 'package:purity/core/widgets/app_toasts.dart';
import 'package:purity/core/widgets/spacing.dart';

import '../../../../app/service_locator.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_form_field.dart';
import '../../../../core/widgets/on_will_pop_dialog.dart';
import '../view_model/login_view_model.dart';
import '../view_model/login_view_model_states.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _viewModel;

  @override
  void initState() {
    _viewModel = serviceLocator<LoginViewModel>();
    _viewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _viewModel,
      child: BlocConsumer<LoginViewModel, LoginViewModelStates>(
        listener: (context, state) async {
          if (state is LoginLoadingState) {
            AppDialogs.showLoadingDialog(
              context: context,
              message: AppStrings.loading.tr(),
            );
          }

          if (state is LoginErrorState) {
            AppNavigator.pop();
            AppToasts.showErrorToast(
              context: context,
              message: state.error.tr(),
            );
          }

          if (state is LoginSuccessState) {
            AppNavigator.pop();
            AppNavigator.navigateTo(isReplace: true, route: Routes.homeRoute);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async =>
                OnWillPopDialog(context: context).onWillPop(),
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                            ImageAssetsManager.splashLogo,
                            width: 150.w,
                          ),
                        ),
                        Spacing.vSize(55.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(
                            children: [
                              Form(
                                key: _viewModel.formKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  children: <Widget>[
                                    DefaultFormField(
                                      context: context,
                                      controller:
                                          _viewModel.userCodeController!,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      onValidate: MultiValidator([
                                        // RequiredValidator(
                                        //   errorText: AppStrings.requiredField
                                        //       .tr(),
                                        // ),
                                        // EmailValidator(
                                        //   errorText: AppStrings.invalidEmail
                                        //       .tr(),
                                        // ),
                                      ]).call,
                                      labelText: AppStrings.email.tr(),
                                      prefixIcon: Icons.person,
                                    ),
                                    Spacing.vSize(16.h),
                                    DefaultFormField(
                                      context: context,
                                      controller:
                                          _viewModel.passwordController!,
                                      isSecure: _viewModel.isPasswordHidden,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onValidate: MultiValidator([
                                        // RequiredValidator(
                                        //   errorText: AppStrings.requiredField
                                        //       .tr(),
                                        // ),
                                        // MinLengthValidator(
                                        //   8,
                                        //   errorText: AppStrings.shortPassword
                                        //       .tr(),
                                        // ),
                                      ]).call,
                                      labelText: AppStrings.password.tr(),
                                      prefixIcon: Icons.lock,
                                      suffixIcon: _viewModel.isPasswordHidden
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      suffixPressed: () {
                                        _viewModel.changePasswordVisibility();
                                      },
                                    ),
                                    Spacing.vSize(45.h),
                                    DefaultButton(
                                      text: AppStrings.login.tr(),
                                      function: () => _viewModel.login(context),
                                      width: 200.w,
                                      background: Theme.of(
                                        context,
                                      ).primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
