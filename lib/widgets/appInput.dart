import 'package:demo_b/constants/appStyle.dart';
import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  AppInput(
      {this.hintText,
      this.labelText,
      this.errorText,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      this.outlined = false,
      this.multiline = 1,
      this.search = false,
      this.onSearch});

  final String hintText;
  final String labelText;
  final String errorText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final bool outlined;
  final int multiline;
  final bool search;
  final Function() onSearch;

  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool showPassword = false;
  GlobalKey _orderFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: _orderFormKey,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: widget.multiline,
      obscureText: widget.obscureText && !showPassword,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.search
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: widget.onSearch,
                )
              : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  })
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: widget.outlined
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8))
              : InputBorder.none,
          hintText: widget.hintText ?? widget.hintText,
          hintStyle: AppStyle.title2Grey,
          labelText: widget.labelText ?? widget.labelText,
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
