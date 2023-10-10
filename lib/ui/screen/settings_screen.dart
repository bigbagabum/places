import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = false;
  late ThemeInteractor appThemeInteractor;

  @override
  void initState() {
    super.initState();
    appThemeInteractor = context.read<ThemeInteractor>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Center(
            child: Text(AppStrings.appTitleSettings,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColorLight,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    height: 1)),
          )),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  AppStrings.darkTheme,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColorLight,
                    fontFamily: "Roboto",
                  ),
                ),
                const Divider(),
                Consumer<ThemeInteractor>(
                    builder: (context, appThemeInteractor, child) {
                  return CupertinoSwitch(
                    value: ThemeInteractor.isBlack,
                    onChanged: (bool value) {
                      setState(() {
                        appThemeInteractor.changeTheme(value);
                      });
                    },
                  );
                })
              ],
            ),
          ),
          Container(
              height: 1,
              width: double.infinity,
              color: const Color.fromRGBO(124, 126, 146, 0.3),
              margin: const EdgeInsets.only(left: 16, right: 16)),
          Container(
              padding: const EdgeInsets.only(left: 5.0, right: 30.0),
              height: 50,
              width: double.infinity,
              //color: Colors.amber,
              child: Row(
                children: [
                  Text(
                    AppStrings.openTutorial,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColorLight,
                      fontFamily: "Roboto",
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Image(
                        image: AssetImage(AppAssets.iconInformation)),
                  ),
                ],
              )),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ],
      ),
    );
  }
}
