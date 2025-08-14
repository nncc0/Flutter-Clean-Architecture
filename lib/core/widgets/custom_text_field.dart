// 📝 Custom Text Field
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextFieldType { text, email, password, number, phone }

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextFieldType textFieldType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final bool autofocus;
  final FocusNode? focusNode;
  
  const CustomTextField({
    this.labelText,
    this.hintText,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.textFieldType = TextFieldType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.autofocus = false,
    this.focusNode,
    Key? key,
  }) : super(key: key);
  
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
    
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }
  
  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: _getKeyboardType(),
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: _buildSuffixIcon(),
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
  
  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType!;
    }
    
    switch (widget.textFieldType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.text:
      default:
        return TextInputType.text;
    }
  }
  
  Widget? _buildSuffixIcon() {
    if (widget.textFieldType == TextFieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    
    return widget.suffixIcon;
  }
}
