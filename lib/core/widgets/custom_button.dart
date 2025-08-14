// 🔘 Custom Button
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType buttonType;
  final Widget? icon;
  final double? width;
  final double? height;
  
  
  const CustomButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.buttonType = ButtonType.primary,
    this.icon,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final button = _buildButton(context);
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    
    return button;
  }
  
  Widget _buildButton(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildButtonContent(context),
        );
      case ButtonType.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          child: _buildButtonContent(context),
        );
      case ButtonType.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildButtonContent(context),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildButtonContent(context),
        );
    }
  }
  
  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            buttonType == ButtonType.outline || buttonType == ButtonType.text
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
          ),
        ),
      );
    }
    
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      );
    }
    
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp),
    );
  }
}
