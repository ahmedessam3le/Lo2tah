import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lo2tah/config/routes/app_navigator.dart';
import 'package:lo2tah/core/widgets/app_dialogs.dart';
import 'package:lo2tah/core/widgets/app_toasts.dart';
import 'package:lo2tah/core/widgets/spacing.dart';

import '../../../../app/service_locator.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_form_field.dart';
import '../view_models/change_password_states.dart';
import '../view_models/change_password_view_model.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late ChangePasswordViewModel _viewModel;

  @override
  void initState() {
    _viewModel = serviceLocator<ChangePasswordViewModel>();
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
      child: BlocConsumer<ChangePasswordViewModel, ChangePasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordLoadingState) {
            AppDialogs.showLoadingDialog(
              context: context,
              message: AppStrings.loading.tr(),
            );
          }

          if (state is ChangePasswordErrorState) {
            AppNavigator.pop();
            AppToasts.showErrorToast(
              context: context,
              message: state.error.tr(),
            );
          }

          if (state is ChangePasswordSuccessState) {
            AppNavigator.pop();
            AppToasts.showSuccessToast(
              context: context,
              message: AppStrings.passwordChangedSuccessfully.tr(),
            );

            Future.delayed(
              const Duration(milliseconds: 2100),
              () => AppNavigator.pop(),
            );
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              AppNavigator.pop();
              return true;
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: AppStrings.changePassword.tr(),
                showBackButton: true,
              ),
              body: Center(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _viewModel.formKey,
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          Image.asset(
                            ImageAssetsManager.changePasswordIcon,
                            width: 200.w,
                            height: 200.h,
                            fit: BoxFit.cover,
                          ),
                          Spacing.vSize(30.h),
                          DefaultFormField(
                            context: context,
                            controller: _viewModel.oldPasswordController!,
                            keyboardType: TextInputType.visiblePassword,
                            isSecure: _viewModel.isOldPasswordHidden,
                            textInputAction: TextInputAction.next,
                            onValidate: MultiValidator([
                              RequiredValidator(
                                errorText: AppStrings.requiredField.tr(),
                              ),
                              MinLengthValidator(
                                8,
                                errorText: AppStrings.shortPassword.tr(),
                              ),
                            ]).call,
                            labelText: AppStrings.oldPassword.tr(),
                            prefixIcon: CupertinoIcons.lock_open_fill,
                            suffixIcon: _viewModel.isOldPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            suffixPressed: () {
                              _viewModel.changeOldPasswordVisibility();
                            },
                          ),
                          Spacing.vSize(20.h),
                          DefaultFormField(
                            context: context,
                            controller: _viewModel.newPasswordController!,
                            keyboardType: TextInputType.visiblePassword,
                            isSecure: _viewModel.isNewPasswordHidden,
                            textInputAction: TextInputAction.next,
                            onValidate: MultiValidator([
                              RequiredValidator(
                                errorText: AppStrings.requiredField.tr(),
                              ),
                              MinLengthValidator(
                                8,
                                errorText: AppStrings.shortPassword.tr(),
                              ),
                            ]).call,
                            labelText: AppStrings.newPassword.tr(),
                            prefixIcon: Icons.lock,
                            suffixIcon: _viewModel.isNewPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            suffixPressed: () {
                              _viewModel.changeNewPasswordVisibility();
                            },
                          ),
                          Spacing.vSize(20.h),
                          DefaultFormField(
                            context: context,
                            controller:
                                _viewModel.confirmNewPasswordController!,
                            keyboardType: TextInputType.visiblePassword,
                            isSecure: _viewModel.isConfirmPasswordHidden,
                            textInputAction: TextInputAction.done,
                            onValidate: (value) {
                              if (value?.trim() == '' || value!.isEmpty) {
                                return AppStrings.requiredField.tr();
                              }
                              if (value.length < 8) {
                                return AppStrings.shortPassword.tr();
                              }
                              if (_viewModel.newPasswordController!.text !=
                                  _viewModel
                                      .confirmNewPasswordController!
                                      .text) {
                                return AppStrings.passwordMismatch.tr();
                              }
                              return null;
                            },
                            labelText: AppStrings.confirmNewPassword.tr(),
                            prefixIcon: Icons.lock,
                            suffixIcon: _viewModel.isConfirmPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            suffixPressed: () {
                              _viewModel.changeConfirmPasswordVisibility();
                            },
                          ),
                          Spacing.vSize(30.h),
                          DefaultButton(
                            isUpperCase: true,
                            function: () {
                              _viewModel.changePassword(context: context);
                            },
                            text: AppStrings.changePassword.tr(),
                          ),
                        ],
                      ),
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
