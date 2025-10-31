import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/navigation/bottom_custglow.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/preferences/preference_handler.dart';
import 'package:glowtap/glowtap/view_customer/registerpage.dart';

class LoginCustGlow extends StatefulWidget {
  const LoginCustGlow({super.key});
  static const id = "/loginCustGlow";
  @override
  State<LoginCustGlow> createState() => _LoginCustGlowState();
}

class _LoginCustGlowState extends State<LoginCustGlow> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisibility = false;
  final fontcustom = 'Josefin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [buildBackground(), buildLayer()]));
  }

  login() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Bottom_CustGlow()),
    );
  }

  final _formKey = GlobalKey<FormState>();
  SafeArea buildLayer() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: 30,
            top: 250,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5).withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Appcolor.pink1,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      fontFamily: fontcustom,
                      color: Color(0xFFE4A1A1),
                    ),
                  ),
                  height(12),
                  Text(
                    "Masuk untuk mengakses akun anda",
                    // style: TextStyle(fontSize: 14, color: AppColor.gray88),
                  ),
                  height(5),
                  buildTitle("Email Address"),
                  height(10),
                  buildTextField(
                    hintText: "Masukkan email",
                    icon: Icon(
                      Icons.email_outlined,
                      color: Appcolor.textBrownSoft.withOpacity(0.8),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email tidak boleh kosong";
                      } else if (!value.contains('@')) {
                        return "Email tidak valid";
                      } else if (!RegExp(
                        r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                      ).hasMatch(value)) {
                        return "Format Email tidak valid";
                      }
                      return null;
                    },
                  ),

                  height(5),
                  buildTitle("Password"),
                  height(10),
                  buildTextField(
                    hintText: "Masukkan password",
                    icon: Icon(
                      Icons.lock_outline,
                      color: Appcolor.textBrownSoft.withOpacity(0.8),
                    ),
                    isPassword: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password tidak boleh kosong";
                      } else if (value.length < 6) {
                        return "Password minimal 6 karakter";
                      }
                      return null;
                    },
                  ),
                  height(5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomeScreen()),
                        // );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MeetSebelas()),
                        // );
                      },
                      child: Text(
                        "Lupa Password?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Appcolor.rosegoldDark,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontcustom,
                        ),
                      ),
                    ),
                  ),
                  height(0.5),
                  LoginButton(
                    text: "Masuk",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print(emailController.text);
                        PreferenceHandler.saveLogin(true);
                        final data = await DbHelper.loginUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Bottom_CustGlow(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Email atau password salah",
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Validation Error"),
                              content: Text("Please fill all fields"),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),

                  height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "atau",
                        // style: TextStyle(fontSize: 12, color: AppColor.gray88),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 8),

                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  height(16),
                  SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          height: 40,
                          width: 40,
                        ),
                        width(10),
                      ],
                    ),
                  ),
                  height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum memiliki akun?",
                        // style: TextStyle(fontSize: 12, color: AppColor.gray88),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterCustglow(),
                            ),
                          );
                        },
                        child: Text(
                          "Daftar Sekarang",
                          style: TextStyle(
                            fontSize: 12,
                            color: Appcolor.rosegoldDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundd.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  TextFormField buildTextField({
    String? hintText,
    Icon? icon,
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword ? isVisibility : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        filled: true,
        fillColor: Appcolor.softPinkPastel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Appcolor.textBrownLight, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                },
                icon: Icon(
                  isVisibility ? Icons.visibility_off : Icons.visibility,
                  // color: AppColor.gray88,
                ),
              )
            : null,
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);
  SizedBox width(double width) => SizedBox(width: width);

  Widget buildTitle(String text) {
    return Row(
      children: [
        // Text(text, style: TextStyle(fontSize: 12, color: AppColor.gray88)),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, this.onPressed, required this.text});
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.button1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          // "Login",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
