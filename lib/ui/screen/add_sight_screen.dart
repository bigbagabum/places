import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/categories_screen.dart';

import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class CardItem {
  final String img;
  final int imgId;

  const CardItem(this.img, this.imgId);
}

class _AddSightScreenState extends State<AddSightScreen> {
  bool isButtonDisabled = true;
  int imgId = 0;
  // кнопка добавления
  Widget addNewImage() {
    return GestureDetector(
      onTap: () => setState(() {
        imageList.add(CardItem(mockImages[Random().nextInt(2)], imgId));
        imgId++;
      }),
      child: const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Image(
          image: AssetImage(AppAssets.iconAddImage),
          width: 72,
          height: 72,
        ),
      ),
    );
  }

  void deleteFromImageList(imgID) {
    setState(() {
      //   imageList.removeAt(imageList
      //       .indexOf(imageList.firstWhere((element) => element.imgId == imgID)));
      imageList
          .removeAt(imageList.indexWhere((element) => element.imgId == imgID));
    });
  }

// одна отдельная карточка картинки
  Widget imageListItem(String img, listK) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Dismissible(
        direction: DismissDirection.up,
        key: ValueKey(listK),
        background: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image(image: AssetImage(AppAssets.dismissUp))],
        ),
        onDismissed: (_) => deleteFromImageList(listK),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: 72,
          height: 72,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(children: [
              Positioned.fill(
                child: Image(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
              Row(children: [
                Spacer(),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () => deleteFromImageList(listK),
                      child: Image(
                        image: AssetImage(AppAssets.iconCancel),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    )),
              ])
            ]),
          ),
        ),
      ),
    );
  }

  List<CardItem> imageList = [];

  Widget listOfImages() {
    return Row(
        children: imageList
            .map((item) => imageListItem(item.img, item.imgId))
            .toList());
  }

  String choisedCat = AppStrings.noChoise;

  final textFieldNameController = TextEditingController();
  final textFieldLatController = TextEditingController();
  final textFieldLonController = TextEditingController();
  final textFieldDescriptionController = TextEditingController();

  final FocusNode focusName = FocusNode();
  final FocusNode focusLat = FocusNode();
  final FocusNode focusLon = FocusNode();

  @override
  void initState() {
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
        child: const Padding(
          padding: EdgeInsets.only(right: 14),
          child: Image(
            image: AssetImage(
              AppAssets.iconCancel,
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
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
    return isGrey ? Theme.of(context).primaryColorDark : Colors.green;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(
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
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  addNewImage(),
                  listOfImages(),
                ]),
              ),
            ),
            const SizedBox(
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Image(
                    image: const AssetImage(AppAssets.iconNextScreen),
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
              ]),
            ),
            Container(
              color: const Color.fromARGB(56, 124, 126, 146),
              width: double.infinity,
              height: 1.0,
            ),
            const SizedBox(
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
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextField(
                onChanged: (_) => _isAllFieldsFilled(),
                focusNode: focusName,
                controller: textFieldNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    border: const OutlineInputBorder(),
                    labelText: AppStrings.exampleName,
                    suffixIconConstraints:
                        const BoxConstraints(minHeight: 20, minWidth: 20),
                    suffixIcon: _suffixClearButton(
                        focusName.hasFocus, textFieldNameController)),
              ),
            ),
            const SizedBox(
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
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^-?[0-9]+\.?[0-9]*$'))
                      ],
                      onChanged: (_) {
                        _isAllFieldsFilled();
                      },
                      focusNode: focusLat,
                      controller: textFieldLatController,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: AppStrings.latitude,
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          suffixIconConstraints:
                              const BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: _suffixClearButton(
                              focusLat.hasFocus, textFieldLatController)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.longitude,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^-?[0-9]+\.?[0-9]*$'))
                      ],
                      keyboardType: TextInputType.number,
                      focusNode: focusLon,
                      onChanged: (_) => _isAllFieldsFilled(),
                      controller: textFieldLonController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          border: const OutlineInputBorder(),
                          labelText: AppStrings.longitude,
                          suffixIconConstraints:
                              const BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: _suffixClearButton(
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
            const SizedBox(
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
            const SizedBox(
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
                border: const OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
                labelText: AppStrings.enterText,
              ),
            ),
            const Spacer(),
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
                              SightStatus.sightToVisit,
                              mocks.last.sightId + 1);

                          mocks.add(newPlace);
                          // print(newPlace.name);
                          Navigator.pop(context);
                        },
                  child: const Text(
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
