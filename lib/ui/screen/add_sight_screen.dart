// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/categories_screen.dart';

import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  bool isButtonDisabled = true;

  String choisedCat = AppStrings.noChoise;

  var textFieldNameController = TextEditingController();
  var textFieldLatController = TextEditingController();
  var textFieldLonController = TextEditingController();
  var textFieldDescriptionController = TextEditingController();

  var focusName = FocusNode();
  var focusLat = FocusNode();
  var focusLon = FocusNode();

  Widget SuffixClearButton(
      bool isInFocus, TextEditingController currentTextController) {
    if (isInFocus && currentTextController.text.isNotEmpty) {
      return GestureDetector(
        onTap: () {
          setState(() {
            currentTextController.clear();
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: SvgPicture.asset(
            AppAssets.iconCancel,
          ),
        ),
      );
    }
    return Container();
  }

  void _IsAllFieldsFilled() {
    if (textFieldDescriptionController.text == '' ||
        textFieldLatController.text == '' ||
        textFieldLonController.text == '' ||
        textFieldNameController.text == '' ||
        choisedCat == AppStrings.noChoise) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  Color MyButtonColor(bool isGrey) {
    return isGrey ? Colors.grey : Colors.green;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textFieldNameController.dispose();
    textFieldLatController.dispose();
    textFieldLonController.dispose();
    textFieldDescriptionController.dispose();

    super.dispose();
  }

  IsValidLat(TextEditingController fieldController) {}

  IsValidLon() {}

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.cancel,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 56,
                  ),
                  Text(
                    AppStrings.newPlace,
                    style: TextStyle(
                      fontSize: 18,
                      textBaseline: TextBaseline.ideographic,
                      color: Theme.of(context).primaryColorLight,
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
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                String received = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseCategories()),
                );

                setState(() {
                  choisedCat = received;
                  _IsAllFieldsFilled();
                });
              },
              child: Row(children: [
                Text(
                  choisedCat,
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColorLight),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: SvgPicture.asset(
                    color: Theme.of(context).primaryColorLight,
                    AppAssets.iconNextScreen,
                  ),
                )
              ]),
            ),
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
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
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
                onChanged: (_) => _IsAllFieldsFilled(),
                focusNode: focusName,
                controller: textFieldNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    border: OutlineInputBorder(),
                    labelText: AppStrings.exampleName,
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 20, minWidth: 20),
                    suffixIcon: SuffixClearButton(
                        focusName.hasFocus, textFieldNameController)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.latitude,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextField(
                      onChanged: (_) => _IsAllFieldsFilled(),
                      focusNode: focusLat,
                      controller: textFieldLatController,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppStrings.latitude,
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: SuffixClearButton(
                              focusLat.hasFocus, textFieldLatController)),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.longitude,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextField(
                      focusNode: focusLon,
                      onChanged: (_) => _IsAllFieldsFilled(),
                      controller: textFieldLonController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          border: OutlineInputBorder(),
                          labelText: AppStrings.longitude,
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: SuffixClearButton(
                              focusLon.hasFocus, textFieldLonController)),
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
                    style: TextStyle(color: Theme.of(context).selectedRowColor),
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
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              onChanged: (_) => _IsAllFieldsFilled(),
              controller: textFieldDescriptionController,
              textAlignVertical: TextAlignVertical.top,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                //floatingLabelStyle: false,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
                labelText: AppStrings.enterText,
              ),
            ),
            Spacer(),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          MyButtonColor(isButtonDisabled))),
                  onPressed: isButtonDisabled
                      ? null
                      : () {
                          Sight newPlace = Sight(
                              textFieldNameController.text,
                              'www',
                              textFieldDescriptionController.text,
                              'hotel',
                              double.parse(textFieldLatController.text),
                              double.parse(textFieldLonController.text),
                              'lib/ui/res/images/jazz.jpg',
                              SightStatus.sightToVisit);

                          mocks.add(newPlace);
                          // print(newPlace.name);
                          Navigator.pop(context);
                        },
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
