import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled({this.hint, this.pad, this.controller,this.isSecure=false});
  String? hint;
  double? pad;
  TextEditingController? controller = TextEditingController();
  bool? isSecure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(pad!),
      child: TextFormField(

        validator: (value) {
          if (value!.isEmpty) {
            return 'fill data';
          }
        },
        obscureText: isSecure!,
        controller: controller!,
        decoration: InputDecoration(

            hintText: hint,
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
