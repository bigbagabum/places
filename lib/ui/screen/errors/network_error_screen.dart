import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/router/route_names.dart';

class NetError extends StatelessWidget {
  const NetError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
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
          ),
          const SizedBox(
            height: 200,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.homeTabScreen);
              },
              child: Text(AppStrings.skip,
                  style: Theme.of(context).textTheme.headlineSmall)),
        ],
      ),
    );
  }
}
