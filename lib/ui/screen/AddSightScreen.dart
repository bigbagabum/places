import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';

class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(AppStrings.cancel,
                        style: Theme.of(context).textTheme.headline2),
                  ),
                  SizedBox(
                    width: 56,
                  ),
                  const Text(
                    AppStrings.newPlace,
                    style: TextStyle(
                      fontSize: 18,
                      textBaseline: TextBaseline.ideographic,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.category,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(children: [
              Text(AppStrings.noChoise, style: TextStyle(fontSize: 16)),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Image(
                  image: AssetImage(AppAssets.iconNextScreen),
                ),
              )
            ]),
            Container(
              color: Color.fromARGB(56, 124, 126, 146),
              width: double.infinity,
              height: 1.0,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Text(
                  AppStrings.placeName,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Золотая долина',
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.latitude),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppStrings.latitude,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.longitude),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppStrings.longitude,
                      ),
                    ),
                  ),
                ],
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.showOnMap,
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 37,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.description,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              textAlignVertical: TextAlignVertical.top,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                //floatingLabelStyle: false,
                border: OutlineInputBorder(),
                labelText: AppStrings.enterText,
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
                    AppStrings.createPlace,
                    style: TextStyle(fontSize: 14),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
