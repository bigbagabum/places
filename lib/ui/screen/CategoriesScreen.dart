import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

class ChooseCategories extends StatelessWidget {
  ChooseCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: Row(children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image(
                  image: AssetImage(AppAssets.iconBackScreen),
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              SizedBox(
                width: 80,
              ),
              Text(
                AppStrings.newPlace,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColorLight,
                  textBaseline: TextBaseline.ideographic,
                ),
              )
            ]),
          ),
          SizedBox(height: 24),
          SizedBox(
            height: 48,
            //width: double.infinity,
            child: TextButton(
                child: Text(
                  AppStrings.typeCafe,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onPressed: () {}),
          ),
          SizedBox(
            height: 48,
            child: TextButton(
              child: Text(
                AppStrings.typeHotel,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 48,
            child: TextButton(
              child: Text(
                AppStrings.typeMuseum,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 48,
            child: TextButton(
              child: Text(
                AppStrings.typePark,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 48,
            child: TextButton(
              child: Text(
                AppStrings.typePartikularPlace,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 48,
            child: TextButton(
              child: Text(
                AppStrings.typeRestourant,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              onPressed: () {},
            ),
          ),
          Spacer(),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () {},
                child: Text(
                  AppStrings.savePlace,
                  style: TextStyle(fontSize: 14),
                )),
          )
        ]),
      ),
    );
  }
}
