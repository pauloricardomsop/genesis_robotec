import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color ?? Colors.white),
        ),
      ),
    );
  }
}

class LoadingStacked extends StatelessWidget {
  const LoadingStacked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            color: AppColors.grey.withOpacity(0.4),
          ),
          Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
