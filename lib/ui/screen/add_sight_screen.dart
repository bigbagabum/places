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

  // late final FocusNode focusName;
  // // late final FocusNode focusLat;
  // late final FocusNode focusLon;

  late final FocusNode focusNode;

  //var _coordinateFieldValidator(TextInputConfiguration)

  @override
  void initState() {
    // focusNamee = FocusNode();
    // focusLat = FocusNode();
    // focusLon = FocusNode();

    focusNode = FocusNode();

    focusNode.addListener(() => setState(() {}));

    // focusName.addListener(() => setState(() {}));
    // focusLat.addListener(() => setState(() {}));
    // focusLon.addListener(() => setState(() {}));

    super.initState();
  }

  Widget _suffixClearButton(
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

  void _isAllFieldsFilled() {
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

  Color _myButtonColor(bool isGrey) {
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

    focusNode.dispose();

    // focusName.dispose();
    // focusLat.dispose();
    // focusLon.dispose();

    super.dispose();
  }

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
                  _isAllFieldsFilled();
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
                onChanged: (_) => _isAllFieldsFilled(),
                focusNode: focusNode,
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
                    suffixIcon: _suffixClearButton(
                        focusNode.hasFocus, textFieldNameController)),
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
                      onChanged: (_) => _isAllFieldsFilled(),
                      focusNode: focusNode,
                      controller: textFieldLatController,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppStrings.latitude,
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: _suffixClearButton(
                              focusNode.hasFocus, textFieldLatController)),
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
                      keyboardType: TextInputType.number,
                      focusNode: focusNode,
                      onChanged: (_) => _isAllFieldsFilled(),
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
                          suffixIcon: _suffixClearButton(
                              focusNode.hasFocus, textFieldLonController)),
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
              onChanged: (_) => _isAllFieldsFilled(),
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
                          _myButtonColor(isButtonDisabled))),
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
