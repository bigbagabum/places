import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';

class SightDetails extends StatefulWidget {
  SightDetails({Key? key, required Sight detailSight}) : super(key: key) {
    this.sight = detailSight;
  }

  late Sight sight;

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  //Sight sight = sight;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    child: Image(
                      image: AssetImage(widget.sight.img),
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),

                          //child
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.only(left: 16, top: 36),
                        child: Image(
                            color: Theme.of(context).primaryColorLight,
                            image: AssetImage('lib/ui/res/icons/back.png'))),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 0,
            //   width: double.infinity,
            // ),
            Expanded(
              child: Container(
                //height: 388,
                width: double.infinity,
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.sight.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.sight.type,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'Roboto'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16.0),
                          child: const Text(
                            'открыто 24 часа',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Color.fromARGB(255, 124, 126, 146),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 72,
                      margin: const EdgeInsets.only(top: 24.0, bottom: 24),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.sight.details,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        height: 48,
                        width: 328,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.green),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Image(
                                  image: AssetImage('lib/ui/res/icons/way.png'),
                                ),
                              ),
                              Text(
                                AppStrings.builtRoute,
                                style: Theme.of(context).textTheme.headline1,
                                // TextStyle(
                                //     fontSize: 14,
                                //     fontFamily: 'Roboto',
                                //     color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 328,
                        height: 1,
                        color: const Color.fromRGBO(124, 126, 146, 0.56),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              //width: 164,
                              height: 40,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Image(
                                      image: AssetImage(
                                          'lib/ui/res/icons/calendar.png'),
                                      color: AppColors.darkIcon),
                                  Text(
                                    'Запланировать',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 58, 63, 91)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              //width: 164,
                              height: 40,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Image(
                                      image: AssetImage(
                                          'lib/ui/res/icons/heart_icon.png'),
                                      color: AppColors.darkIcon),
                                  Text(
                                    'В избранное',
                                    style: TextStyle(
                                      //fontFamily: 'Roboto',
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 58, 63, 91),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
