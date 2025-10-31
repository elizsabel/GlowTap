import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/model/customer_model.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterCustglow extends StatefulWidget {
  const RegisterCustglow({super.key});
  static const id = "/registercust";
  @override
  State<RegisterCustglow> createState() => _RegisterCustGlowState();
}

class _RegisterCustGlowState extends State<RegisterCustglow> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool isVisibility = false;
  bool isFilled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkFields);
    passwordController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      isFilled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [buildBackground(), buildLayer()]));
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
            top: 100,
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
                    "Welcome",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  height(12),
                  Text(
                    "Register to access your account",
                    // style: TextStyle(fontSize: 14, color: AppColor.gray88),
                  ),
                  height(10),
                  buildTitle("Nama"),
                  height(5),
                  buildTextField(
                    hintText: "Masukkan Nama Anda",
                    icon: Icon(
                      Icons.person_2_outlined,
                      color: Appcolor.textBrownSoft.withOpacity(0.8),
                    ),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                  ),

                  height(10),
                  buildTitle("No. Handphone"),
                  height(5),
                  buildTextField(
                    hintText: "Masukkan No. Handphone Anda",
                    icon: Icon(
                      Icons.phone_android_outlined,
                      color: Appcolor.textBrownSoft.withOpacity(0.8),
                    ),
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor HP tidak boleh kosong';
                      } else if (value.length < 11) {
                        return 'Nomor HP minimal 11 angka';
                      }
                      return null;
                    },
                  ),

                  height(10),
                  buildTitle("Email Address"),
                  height(5),
                  buildTextField(
                    hintText: "Masukkan Email Anda",
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

                  height(10),
                  buildTitle("Password"),
                  height(5),
                  buildTextField(
                    hintText: "Masukkan password Anda",
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

                  height(10),
                  buildTitle("Alamat Domisili"),
                  height(5),
                  buildTextField(
                    hintText: "Masukkan Alamat Anda",
                    icon: Icon(
                      Icons.location_city_outlined,
                      color: Appcolor.textBrownSoft.withOpacity(0.8),
                    ),
                    controller: cityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Alamat tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  height(20),
                  LoginButton(
                    text: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final CustomerModel data = CustomerModel(
                          name: nameController.text,
                          username: cityController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        DbHelper.registerUser(data);
                        Fluttertoast.showToast(msg: "Pendaftaran Berhasil");
                        Navigator.pop(context);
                      } else {}
                    },
                  ),

                  height(16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah memiliki akun?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            // color: AppColor.blueButton,
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
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Appcolor.textBrownLight, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Appcolor.textBrownLight.withOpacity(0.2),
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
      height: 56,
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
