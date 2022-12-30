import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

//row with category and marker if this cat is choised
class CategoryRow extends StatelessWidget {
  final CatRow cat;
  const CategoryRow({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: (() {}),
            child: Row(
              children: [
                Text(
                  cat.catName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                Spacer(),
                Text(cat.catChoised.toString())
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
  }
}

class CatRow {
  String catName;
  bool catChoised;
  CatRow(this.catName, this.catChoised);
}

class ChooseCategories extends StatefulWidget {
  ChooseCategories({Key? key}) : super(key: key);

  static bool isButtonDesible = true;

  // static String get cat {
  //   return _ChooseCategoriesState.isCafe
  //       ? AppStrings.typeCafe
  //       : _ChooseCategoriesState.isHotel
  //           ? AppStrings.typeHotel
  //           : _ChooseCategoriesState.isMuseum
  //               ? AppStrings.typeMuseum
  //               : _ChooseCategoriesState.isPark
  //                   ? AppStrings.typePark
  //                   : _ChooseCategoriesState.isRestourant
  //                       ? AppStrings.typeRestourant
  //                       : _ChooseCategoriesState.IsParticularPlace
  //                           ? AppStrings.typePartikularPlace
  //                           : AppStrings.noChoise;
  // }

  @override
  State<ChooseCategories> createState() => _ChooseCategoriesState();
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  final cats = [
    CatRow(AppStrings.typeCafe, false),
    CatRow(AppStrings.typeHotel, false),
    CatRow(AppStrings.typeMuseum, false),
    CatRow(AppStrings.typePark, false),
    CatRow(AppStrings.typePartikularPlace, false),
    CatRow(AppStrings.typeRestourant, false),
  ];

  // Написать функцию которая обрабатывает ТАПы по категориям
  //

  void CategoryChoised() {}

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
          //here list of category from up to down
          Column(
              children: cats
                  .map((item) => CategoryRow(
                        cat: item,
                      ))
                  .toList()),

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
