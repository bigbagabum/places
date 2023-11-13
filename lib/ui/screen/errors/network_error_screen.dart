import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

class NetError extends StatelessWidget {
  const NetError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage(AppAssets.networkError)),
        const SizedBox(
          height: 8,
        ),
        Text(
          AppStrings.dialogApiError,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          AppStrings.dialogApiErrorLine2,
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
