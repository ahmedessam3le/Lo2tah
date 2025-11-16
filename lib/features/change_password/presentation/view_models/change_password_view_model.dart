import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2tah/features/change_password/presentation/view_models/change_password_states.dart';

class ChangePasswordViewModel extends Cubit<ChangePasswordStates> {
  ChangePasswordViewModel() : super(ChangePasswordInitialState());

  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  TextEditingController? oldPasswordController;
  TextEditingController? newPasswordController;
  TextEditingController? confirmNewPasswordController;

  bool _isOldPasswordHidden = true;

  bool get isOldPasswordHidden => _isOldPasswordHidden;

  bool _isNewPasswordHidden = true;

  bool get isNewPasswordHidden => _isNewPasswordHidden;

  bool _isConfirmPasswordHidden = true;

  bool get isConfirmPasswordHidden => _isConfirmPasswordHidden;

  void changeOldPasswordVisibility() {
    _isOldPasswordHidden = !_isOldPasswordHidden;
    emit(ChangePasswordChangeVisibilityState());
  }

  void changeNewPasswordVisibility() {
    _isNewPasswordHidden = !_isNewPasswordHidden;
    emit(ChangePasswordChangeVisibilityState());
  }

  void changeConfirmPasswordVisibility() {
    _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    emit(ChangePasswordChangeVisibilityState());
  }

  void init() {
    formKey = GlobalKey<FormState>();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
  }

  Future<void> changePassword({required BuildContext context}) async {
    if (!formKey!.currentState!.validate()) {
      return;
    }

    emit(ChangePasswordLoadingState());

    // var response = await changePasswordUsecase(
    //   context: context,
    //   oldPassword: oldPasswordController!.text,
    //   newPassword: newPasswordController!.text,
    // );
    //
    // response.fold(
    //   (failure) => emit(ChangePasswordErrorState(failure.message)),
    //   (sent) {
    //     oldPasswordController?.clear();
    //     newPasswordController?.clear();
    //     confirmNewPasswordController?.clear();
    //     emit(ChangePasswordSuccessState());
    //   },
    // );

    await Future.delayed(const Duration(milliseconds: 750));
    emit(ChangePasswordSuccessState());
  }

  void dispose() {
    close().then((value) {
      oldPasswordController!.clear();
      oldPasswordController!.dispose();
      newPasswordController!.clear();
      newPasswordController!.dispose();
      confirmNewPasswordController!.clear();
      confirmNewPasswordController!.dispose();
      formKey = null;
    });
  }
}
