import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lo2tah/config/log/logger.dart';
import 'package:lo2tah/features/home/presentation/view_model/home_view_states.dart';

class HomeViewModel extends Cubit<HomeViewStates> {
  HomeViewModel() : super(HomeInitialState());

  final GlobalKey barCodeKey = GlobalKey(debugLabel: 'Barcode');
  MobileScannerController? controller;
  bool? isCameraPermissionGranted;
  List<Barcode> barcodes = [];
  AudioPlayer? audioPlayer;

  // In your HomeViewModel class
  AudioPlayer? _audioPlayer;

  Future<void> init() async {
    controller = MobileScannerController(
      autoStart: true,
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 2000,
      autoZoom: true,
      torchEnabled: false,
    );
    _audioPlayer = AudioPlayer();
    await _audioPlayer?.setAsset('assets/audio/beep.mp3');
    audioPlayer = AudioPlayer();
    await audioPlayer!.setVolume(1);

    isCameraPermissionGranted = await _requestCameraPermission();
    if (!isCameraPermissionGranted!) {
      isCameraPermissionGranted = await _requestCameraPermission();
    }
    emit(HomeInitialState());
  }

  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<void> onDetect(BarcodeCapture capture) async {
    try {
      playDetectSound();
      barcodes = capture.barcodes;
      final barcode = barcodes.last;
      emit(HomeBarcodeLoadedState(barcode));
    } catch (e, s) {
      Logger.print(title: 'onQRViewCreated Error', message: s.toString());
    }
  }

  Future<void> playDetectSound() async {
    try {
      await _audioPlayer?.seek(Duration.zero);
      await _audioPlayer?.play();
      Logger.print(title: 'Audio Played', message: 'Success');
    } catch (e) {
      Logger.print(title: 'Audio Play Error', message: e.toString());
    }
  }

  @override
  Future<void> close() async {
    await _audioPlayer?.dispose();
    audioPlayer?.dispose();
    return super.close();
  }
}
