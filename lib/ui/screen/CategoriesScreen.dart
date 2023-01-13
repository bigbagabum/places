import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

import 'AddSightScreen.dart';

class CatRow {
  // класс строки классов показывающий выбобр или не выбор текущей категории
  String _catName;
  bool _catChoised;
  CatRow(this._catName, this._catChoised);
}

class ChooseCategories extends StatefulWidget {
  ChooseCategories({Key? key, required String catChoised}) : super(key: key);

  String catChoised = AppStrings.noChoise;

  @override
  State<ChooseCategories> createState() => _ChooseCategoriesState();
}

void clearChoise(choiseClear) {
  for (var n in choiseClear) {
    n._catChoised = false;
  }
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  bool isButtonDisabled = true;

  // int itemOfCat = 0;

  Color MyButtonColor(bool isGrey) {
    return isGrey ? Colors.grey : Colors.green;
  }

  Widget showMarker(bool e) {
    if (e == true) {
      return Image(
          image: AssetImage('lib/ui/res/icons/FilterItem.png'),
          color: Colors.green);
    } else {
      return Text('');
    }
  }

  Widget setCategory(CatRow cat) => Column(
        children: [
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: (() {
                setState(
                  () {
                    bool checkStatus = cat._catChoised;
                    clearChoise(cats);
                    cat._catChoised = !checkStatus;
                    isButtonDisabled =
                        checkStatus; //Если категория была выбрана то по клику она становится НЕ выбрана и кнопка Disabled
                    isButtonDisabled ? null : widget.catChoised = cat._catName;
                  },
                );
              }),
              child: Row(
                children: [
                  Text(
                    cat._catName,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  Spacer(),
                  showMarker(cat._catChoised)
                  //Text(cat.catChoised.toString())
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Color.fromARGB(56, 124, 126, 146),
          ),
        ],
      );

  static List cats = [
    CatRow(AppStrings.typeCafe, false),
    CatRow(AppStrings.typeHotel, false),
    CatRow(AppStrings.typeMuseum, false),
    CatRow(AppStrings.typePark, false),
    CatRow(AppStrings.typePartikularPlace, false),
    CatRow(AppStrings.typeRestourant, false),
  ];

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
//Navigator.pop(context, AppStrings.noChoise);
                  Navigator.pop(context, AppStrings.noChoise);
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
          Column(children: cats.map((item) => setCategory(item)).toList()),
          const Spacer(),
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
                        Navigator.pop(context, widget.catChoised);
                        clearChoise(cats);
                      },
                child: const Text(
                  AppStrings.savePlace,
                  style: TextStyle(fontSize: 14),
                )),
          )
        ]),
      ),
    );
  }
}
