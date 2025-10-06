
import 'dart:developer';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/controller/auth_controller.dart';
import 'package:smart_construction_calculator/core/controller/loader_controller.dart';
import 'package:smart_construction_calculator/core/controller/otp_controller.dart';
import 'package:smart_construction_calculator/core/controller/user_controller.dart';

LoaderController get loaderC => Get.find<LoaderController>();

AuthController get authC => Get.find<AuthController>();
UserController get userC => Get.find<UserController>();
OTPController get otpC => Get.find<OTPController>();


String getOTPEmailTemplate(String otp) {
  return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>OTP Email</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    .container {
      max-width: 600px;
      margin: 20px;
      background: #ffffff;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
      text-align: center;
    }
    .header h1 {
      color: #333333;
      font-size: 28px;
      margin-bottom: 20px;
      font-weight: bold;
    }
    .content {
      margin: 20px 0;
    }
    .otp {
      font-size: 48px;
      font-weight: bold;
      color: #000000;
      margin: 30px 0;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      animation: fadeIn 2s ease-in-out;
    }
    .footer {
      font-size: 14px;
      color: #777777;
      margin-top: 30px;
    }
    .footer a {
      color: #007BFF;
      text-decoration: none;
    }
    .footer a:hover {
      text-decoration: underline;
    }
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Your One-Time Password (OTP)</h1>
    </div>
    <div class="content">
      <p>Hello there! 👋</p>
      <p>Please use the following OTP to complete your verification:</p>
      <div class="otp">$otp</div>
      <p>This OTP is valid for <strong>10 minutes</strong>. Do not share it with anyone.</p>
    </div>
    <div class="footer">
      <p>If you did not request this OTP, please ignore this email or <a href="#">contact support</a>.</p>
      <p>Thank you,<br>Your Awesome Team</p>
    </div>
  </div>
</body>
</html>
  ''';
}


