import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_style.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    this.selectedColor,
    this.unSelectedColor,
  });
  final Function()? onTap;
  final bool? isSelected;
  final Color? selectedColor;
  final Color? unSelectedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Select Radio Button",
          style: AppStyle.styleProductSansMediumBlack14(context),
        ),
        const SizedBox(
          width: 4,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unSelectedColor ?? AppColors.white,
              border: Border.all(color: AppColors.black, width: 1),
            ),
            child: Container(
              margin: const EdgeInsets.all(1),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected != true
                    ? unSelectedColor ?? AppColors.white
                    : selectedColor ?? AppColors.backButtonTwoColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
