import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokenauthapp/utils/constant_colors.dart';
import 'package:tokenauthapp/utils/custom_input.dart';
import 'auth_controller.dart';
import 'helper/LoginHelper.dart';

class LoginScreen extends GetWidget<AuthController> {
  //const LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: CommonHelper().appbarCommon("", context, () {
      //   context.popFalse;
      // }),
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          //physics: physicsCommon,
          //physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      const Text("Welcome back! Login",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xff667085),
                            height: 1.4,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 33),
                      const Text("Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xff667085),
                            height: 1.4,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                      const SizedBox(height: 5),
                      CustomInput(
                        controller: controller.usernameController,
                        isNumberField: false,
                        validation: (value) {
                          //bool emailValid = RegExp("^[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9\.]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})\$").hasMatch(value!.trim());
                          //bool emailValid = RegExp("^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})\$").hasMatch(value!.trim());
                          if (value!.isEmpty) {
                            return 'Please enter username';
                          }
                          // else if (!emailValid) {
                          //   return 'Please enter valid email';
                          // }
                          return null;
                        },
                        hintText: "Username",
                        icon: 'assets/icons/user.png',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 8),
                      Text("Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: cc.greyParagraph,
                            height: 1.4,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                      const SizedBox(height: 5),
                      Obx(() =>  Container(
                          margin: const EdgeInsets.only(bottom: 19),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: controller.passwordController,
                            cursorColor: ConstantColors().primaryColor,
                            textInputAction: TextInputAction.next,
                            obscureText: !controller.visibilypw,
                            style: const TextStyle(fontSize: 14),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length < 6) {
                                return 'Please enter minimum 6-12 digits password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: ConstantColors().greySecondary,
                                filled: true,
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 22.0,
                                      width: 40.0,
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icons/lock.png'), fit: BoxFit.fitHeight)),
                                    ),
                                  ],
                                ),
                                suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    controller.visibilypw ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    controller.setVisibility(!controller.visibilypw);
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().warningColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                hintText: 'Password',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 18)),
                          ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: ConstantColors().primaryColor,
                              contentPadding: const EdgeInsets.all(0),
                              title: Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "Remember me",
                                  style: TextStyle(
                                      color: ConstantColors().greyFour,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              value: controller.keeplogin,
                              onChanged: (newValue) {
                                controller.setKeeplogin(newValue!);
                                // setState(() {
                                //   keepLoggedIn = !keepLoggedIn;
                                // });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute<void>(
                              //     builder: (BuildContext context) =>
                              //     const ResetPassEmailPage(),
                              //   ),
                              // );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 122,
                              height: 40,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: cc.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 13),
                      InkWell(
                        onTap: () {
                          if(_formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: cc.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Obx(() => controller.isLoading.value
                                ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                  strokeWidth: 3, color: Colors.white),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  child: const Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ))),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Do not have account?" ' ',
                              style: const TextStyle(
                                  color: Color(0xff646464), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () {Get.toNamed("Routes.signupScreen");},
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: cc.primaryColor,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Divider (or)
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                height: 1,
                                color: cc.greyFive,
                              )),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Text(
                              "OR",
                              //ln.getString("OR"),
                              style: TextStyle(
                                  color: cc.greyPrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                height: 1,
                                color: cc.greyFive,
                              )),
                        ],
                      ),

                      // login with google, facebook button ===========>
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () async {
                            // final User? user = await _signInWithGoogle();
                            // if (user != null) {
                            //   debugPrint("google sign $user}");
                            //   // User signed in successfully.
                            //   // Navigate to the next screen or perform any other actions.
                            // }
                          },
                          child: LoginHelper().commonButton(
                              'assets/icons/google.png', "Sign in with Google",
                              isloading: false)
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            // if (gProvider.isloading == false) {
                            //   gProvider.googleLogin(context);
                            // }
                          },
                          child: LoginHelper().commonButton(
                              'assets/icons/facebook.png',
                              "Sign in with Facebook",
                              isloading: false)),
                      // GetBuilder<FacebookLoginService>(
                      //   builder: (fProvider) => InkWell(
                      //     onTap: () {
                      //       if (fProvider.isloading == false) {
                      //         fProvider.checkIfLoggedIn(context);
                      //       }
                      //     },
                      //     child: LoginHelper().commonButton(
                      //         'assets/icons/facebook.png',
                      //         "Sign in with Facebook",
                      //         isloading: fProvider.isloading == false
                      //             ? false
                      //             : true),
                      //   ),
                      // ),
                      // const SizedBox(height: 60),
                    ],
                  ),
                ),
              )
              // }
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
