import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/theme/assets.dart';
import 'package:notesapp/orientation_detection.dart';
import 'package:notesapp/providers/auth_provider.dart';

class OnBoardingScreen extends StatelessWidget {
  // const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<AuthProvider>(
            builder: (AuthProvider _provider) {
              return Expanded(
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      height: OrientationDetection.screenHeight * 0.3,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(Assets.backGroundImage),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _provider.signInGoogle();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text("Sign with Google",
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
            },
          ),
          // )
        ],
      ),
    );
  }
}
