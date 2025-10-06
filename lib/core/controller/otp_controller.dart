import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:smart_construction_calculator/config/res/app_constants.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';

class OTPController extends GetxController {
  TextEditingController? _otpC;

  // Getters
  TextEditingController? get otpC => _otpC;
  String get currentOTP => _otp.value;
  bool get isOtpTimerRunning => _isTimerRunning.value;
  int get remainingTime => _timeLeft.value;

  // Observables
  final RxString _otp = ''.obs;
  final RxBool _isTimerRunning = false.obs;
  final RxInt _timeLeft = 60.obs;

  Timer? _timer;

  @override
  void onInit() {
    _otpC = TextEditingController();
    super.onInit();
  }

  void generateOTP() {
    _otp.value = (1000 + Random().nextInt(9000)).toString();
  }

  Future<void> sendOTP(context) async {
    loaderC.showLoader();
    generateOTP();
    debugPrint('OTP === ${_otp.value}');
    final smtpServer = gmail('amirsohail200rb@gmail.com', 'qvcl hvuq bgus qtlg');
    final message =
        Message()
          ..from = Address('amirsohail200rb@gmail.com', 'UHCONST')
          ..recipients.add(authC.signUpEmailC!.text)
          ..subject = 'UHCONST OTP Verification'
          ..html = getOTPEmailTemplate(_otp.value);

    try {
      await send(message, smtpServer);
       AppUtils.showToast(
      text: 'OTP sent successfully',
      bgColor: CupertinoColors.activeGreen,
      txtClr: CupertinoColors.white,
    );
      startTimer();
    } catch (e) {
      debugPrint(e.toString());
     AppUtils.showToast(
      text: 'Failed to send OTP',
      bgColor: CupertinoColors.destructiveRed,
      txtClr: CupertinoColors.white,
    );
    } finally {
      loaderC.hideLoader();
    }
  }

  void startTimer() {
    _timer?.cancel();
    _isTimerRunning.value = true;
    _timeLeft.value = 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft.value > 0) {
        _timeLeft.value--;
      } else {
        _isTimerRunning.value = false;
        _timer?.cancel();
      }
    });
  }

  Future<void> resendOTP(context) async {
    if (!_isTimerRunning.value) {
      await sendOTP(context);
    }
  }

 bool verifyOTP() {
  debugPrint('Generated OTP: ${_otp.value}');
  debugPrint('Entered OTP: ${_otpC?.text}');
  return _otp.value == _otpC?.text;
}


  @override
  void dispose() {
    _otpC!.dispose();
    super.dispose();
  }
}
