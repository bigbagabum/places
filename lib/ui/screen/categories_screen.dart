import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

List<CatRow> cats = [
  CatRow(AppStrings.typeCafe, false),
  CatRow(AppStrings.typeHotel, false),
  CatRow(AppStrings.typeMuseum, false),
  CatRow(AppStrings.typePark, false),
  CatRow(AppStrings.typePartikularPlace, false),
  CatRow(AppStrings.typeRestourant, false),
];

class CatRow {
  // класс строки классов показывающий выбор или не выбор текущей категории
  final String _catName;
  bool _catChoised;
  CatRow(this._catName, this._catChoised);
}

class ShowMarker extends StatelessWidget {
  final bool flag;
  const ShowMarker({super.key, required this.flag});

  @override
  Widget build(BuildContext context) {
    if (flag) {
      return Image(
          image: const AssetImage(AppAssets.iconFilterItem),
          color: Theme.of(context).selectedRowColor);
    } else {
      return const Text('');
    }
  }
}

class SetCategory extends StatefulWidget {
  final VoidCallback? stateUpdate;
  final CatRow cat;
  const SetCategory({super.key, required this.cat, this.stateUpdate});

  @override
  State<SetCategory> createState() => _SetCategoryState();
}

class _SetCategoryState extends State<SetCategory> {
  String catChoised = AppStrings.noChoise;
  bool isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: (() {
              bool checkStatus = widget.cat._catChoised;

              setState(
                () {
                  clearChoise();
                  widget.cat._catChoised = !checkStatus;
                  isButtonDisabled =
                      checkStatus; //Если категория была выбрана то по клику она становится НЕ выбрана и кнопка Disabled
                  isButtonDisabled ? null : catChoised = widget.cat._catName;
                  ChooseCategories(
                    isButtonDisabled: isButtonDisabled,
                    catChoised: catChoised,
                  );
                },
              );
            }),
            child: Row(
              children: [
                Text(
                  widget.cat._catName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                const Spacer(),
                ShowMarker(flag: widget.cat._catChoised)
                //Text(cat.catChoised.toString())
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          color: Color.fromARGB(56, 124, 126, 146),
        ),
      ],
    );
  }
}

void clearChoise() {
  int n;
  for (n = 0; n < cats.length; n++) {
    cats[n]._catChoised = false;
  }
}

//String catChoised = AppStrings.noChoise; //переменная обозначающая выбранную категорию для передачи в предыдущий экран, по-умолчанию выбор пуст

//late bool isButtonDisabled; // если true главная кнопка не активна

class ChooseCategories extends StatefulWidget {
  final bool isButtonDisabled; // если true главная кнопка не активна
  final String catChoised;

  ChooseCategories(
      {Key? key,
      List<CatRow>? cats,
      required this.isButtonDisabled,
      required this.catChoised})
      : super(key: key) {
    //isButtonDisabled = buttonStatus;
  }

  @override
  State<ChooseCategories> createState() => _ChooseCategoriesState();
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  Color myButtonColor(bool isGrey) {
    return isGrey ? Colors.grey : Theme.of(context).selectedRowColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.primaryColorDark,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: Row(children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, AppStrings.noChoise);
                },
                child: SvgPicture.asset(
                  AppAssets.iconBackScreen,
                  color: theme.primaryColorLight,
                ),
              ),
              const SizedBox(
                width: 80,
              ),
              Text(
                AppStrings.newPlace,
                style: TextStyle(
                  fontSize: 18,
                  color: theme.primaryColorLight,
                  textBaseline: TextBaseline.ideographic,
                ),
              )
            ]),
          ),
          const SizedBox(height: 24),
          Column(
              children: cats
                  .map((item) => SetCategory(
                        cat: item,
                        stateUpdate: () => setState(() {}),
                      ))
                  .toList()),
          const Spacer(),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        myButtonColor(widget.isButtonDisabled))),
                onPressed: widget.isButtonDisabled
                    ? null
                    : () {
                        Navigator.pop(context, widget.catChoised);
                        clearChoise();
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
