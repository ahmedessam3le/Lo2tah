import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:purity/app/service_locator.dart';
import 'package:purity/config/routes/app_navigator.dart';
import 'package:purity/core/utils/colors_manager.dart';
import 'package:purity/core/utils/strings_manager.dart';
import 'package:purity/core/widgets/app_dialogs.dart';
import 'package:purity/features/home/presentation/view_model/home_view_model.dart';
import 'package:purity/features/home/presentation/view_model/home_view_states.dart';
import 'package:purity/features/home/presentation/widgets/corner_overlay_painter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = serviceLocator<HomeViewModel>()..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _viewModel,
      child: BlocConsumer<HomeViewModel, HomeViewStates>(
        listener: (context, state) {
          if (state is HomeBarcodeLoadedState) {
            AppDialogs.showFoundBarcodeDialog(
              context: context,
              title: state.barcode.rawValue ?? 'Barcode',
              message: 'New Barcode',
              confirmButtonLabel: AppStrings.okay.tr(),
              onConfirmButtonPressed: AppNavigator.pop,
            );
          }
        },
        builder: (_, state) {
          return Scaffold(
            body: SafeArea(
              child: Visibility(
                visible: _viewModel.isCameraPermissionGranted ?? false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: MobileScanner(
                        controller: _viewModel.controller,
                        overlayBuilder: (context, constraints) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              final scanArea = Size(
                                constraints.maxWidth * 0.9,
                                constraints.maxHeight * 0.8,
                              );
                              final scanOffset = Offset(
                                (constraints.maxWidth - scanArea.width) / 2,
                                (constraints.maxHeight - scanArea.height) / 2,
                              );

                              return CustomPaint(
                                painter: CornerOverlayPainter(
                                  scanArea: scanArea,
                                  scanOffset: scanOffset,
                                  cornerLength: 20.h,
                                  cornerWidth: 4.w,
                                  cornerColor: ColorsManager.lightPrimaryColor,
                                ),
                                child: Container(),
                              );
                            },
                          );
                        },
                        fit: BoxFit.cover,
                        useAppLifecycleState: true,
                        tapToFocus: true,
                        onDetect: (capture) => _viewModel.onDetect(capture),
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
