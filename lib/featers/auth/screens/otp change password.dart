import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import '../../../common/components.dart';
import '../../../common/translate/strings.dart';
import 'new_password.dart';

class OtpNumber extends StatefulWidget {
  final String phoneNumber;
  final String country;
  const OtpNumber({super.key,required this.phoneNumber,required this.country});
  @override
  State<OtpNumber> createState() => OtpNumberState();
}

class OtpNumberState extends State<OtpNumber>  with SingleTickerProviderStateMixin{
  AnimationController? _animationController;
  int levelClock = 2 * 60;
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _animationController!.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }
  @override
  void dispose() {
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
            child: Container(
              height: 350,
              margin: const EdgeInsets.only(top: 40),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    Strings.verification.tr(context),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    child:  Text(
                      Strings.enterCodeSent.tr(context),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      '+${widget.country} *******${widget.phoneNumber[7]}${widget.phoneNumber[8]}',
                      style:const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Pinput(
                    focusNode: _pinFocusNode,
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                    validator: (value) {
                      if(value == '1111'){
                        navigateAndFinish(context, const NewPassword());
                      }
                      return value == '1111' ? null : 'Pin is incorrect';
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Resend code after: "),
                      Countdown(
                        animation: StepTween(
                          begin: levelClock, // THIS IS A USER ENTERED NUMBER
                          end: 0,
                        ).animate(_animationController!),
                      ),
                    ],
                  ),
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