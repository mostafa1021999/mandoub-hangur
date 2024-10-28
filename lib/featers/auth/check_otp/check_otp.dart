import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:untitled2/common/constants/constanat.dart';
import 'package:untitled2/common/images/images.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import 'package:untitled2/featers/auth/check_otp/check_otp_controller.dart';
import '../../../common/components.dart';
import '../../../common/translate/strings.dart';
import '../forget_password/forget_password_controller.dart';
import '../new_password/new_password.dart';

class OtpNumber extends StatefulWidget {
  String endPhoneNumber;
  String residencyNumber;
  OtpNumber({super.key,required this.endPhoneNumber,required this.residencyNumber});
  @override
  OtpNumberState createState() => OtpNumberState();
}

class OtpNumberState extends StateMVC<OtpNumber> with TickerProviderStateMixin{
  OtpNumberState() : super(CheckOtpController()) {
    con = CheckOtpController();
  }
  late CheckOtpController con;
  late AnimationController? _animationController;
  int levelClock = 4 * 60;
  final FocusNode _pinFocusNode = FocusNode();
  bool isTimerComplete = false; // To track timer completion
  bool _isControllerDisposed = false;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: levelClock),
    );
    _animationController?.addListener(() {
      if (_animationController!.isCompleted) {
        setState(() {
          isTimerComplete = true; // Timer is complete, enable resend button
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController?.forward();
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }
  void _doubleTimer() {
    if (!_isControllerDisposed) {
      setState(() {
        // Double the timer duration
        levelClock *= 2;

        // Check if the controller is disposed before using it
        _animationController?.stop();
        _animationController?.duration = Duration(seconds: levelClock);
        _animationController?.reset(); // Reset the controller to the start

        // Restart the countdown
        isTimerComplete = false;
        _animationController?.forward();
      });
    }
  }
  @override
  void dispose() {
    _isControllerDisposed = true;
    _animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return BlocConsumer<RiderCubit, MandoubState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Image.asset(Images.logoWithoutBackground),
                  Text(
                    Strings.verification.tr(context),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      '+966 *******${widget.endPhoneNumber}',
                      style:const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Pinput(
                    controller: con.otpCodeController,
                    focusNode: _pinFocusNode,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                   onSubmitted: (value){
                     if(value.length==6){
                       con.checkOtpCode(context, widget.residencyNumber);
                     }
                   },
                   onChanged: (value){
                      if(value.length==6){
                        con.checkOtpCode(context, widget.residencyNumber);
                      }
                   },
                  ),
                  const SizedBox(height: 7,),
                  Directionality(
                    textDirection: language=='en'?TextDirection.ltr:TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${Strings.resendCodeAfter.tr(context)}: "),
                        isTimerComplete?
                        TextButton(child:Text(Strings.resend.tr(context)),onPressed: (){
                          _doubleTimer();
                        },)
                        :Countdown(
                          animation: StepTween(
                            begin: levelClock, // THIS IS A USER ENTERED NUMBER
                            end: 0,
                          ).animate(_animationController!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7,),
                  if(con.loading)
                  Center(
                      child: SpinKitWave(color: Colors.grey.shade600, size: 25.0))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
class Countdown extends AnimatedWidget {
  const Countdown({super.key, required this.animation})
      : super(listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}