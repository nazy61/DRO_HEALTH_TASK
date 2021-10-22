import 'package:dro_health/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final bool selected;
  final Function onPressed;
  const FavButton({Key? key, required this.selected, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.purple.withOpacity(0.2),
        ),
        child: selected
            ? Icon(CupertinoIcons.heart_fill, color: AppCustomColors.droPurple)
            : const Icon(CupertinoIcons.heart),
      ),
    );
  }
}
