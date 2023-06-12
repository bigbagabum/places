import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

class CatRow {
  // класс строки классов показывающий выбор или не выбор текущей категории
  final String _catName;
  bool _catChoised;
  CatRow(this._catName, this._catChoised);
}

// ignore: must_be_immutable
class ChooseCategories extends StatefulWidget {
  ChooseCategories({
    Key? key,
  }) : super(key: key);

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

  Color myButtonColor(bool isGrey) {
    return isGrey ? Colors.grey : Theme.of(context).selectedRowColor;
  }

  Widget showMarker(bool e) {
    if (e == true) {
      return Image(
          image: const AssetImage(AppAssets.iconFilterItem),
          color: Theme.of(context).selectedRowColor);
    } else {
      return const Text('');
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
                  const Spacer(),
                  showMarker(cat._catChoised)
                  //Text(cat.catChoised.toString())
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color.fromARGB(56, 124, 126, 146),
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
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: Row(children: [
              TextButton(
                onPressed: () {
//Navigator.pop(context, AppStrings.noChoise);
                  Navigator.pop(context, AppStrings.noChoise);
                },
                child: SvgPicture.asset(
                  AppAssets.iconBackScreen,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              const SizedBox(
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
          const SizedBox(height: 24),
          Column(children: cats.map((item) => setCategory(item)).toList()),
          const Spacer(),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        myButtonColor(isButtonDisabled))),
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
