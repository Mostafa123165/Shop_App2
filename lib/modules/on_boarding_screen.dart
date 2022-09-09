
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp2/lay_out/Shop_Layout.dart';
import 'package:shopapp2/modules/login/login_screnn.dart';
import 'package:shopapp2/shared/components/components.dart';
import 'package:shopapp2/shared/network/local/cash_helper.dart';
import 'package:shopapp2/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image ;
  final String title ;
  final String body ;

  BoardingModel({
    required this.image ,
    required this.body ,
    required this.title ,
});
}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var controler = PageController() ;
   bool islast = false ;
  List<BoardingModel>items = [
    BoardingModel(
        image: "assets/image/first_onBoarding.png",
        body: "body1",
        title: "title1",
    ),
    BoardingModel(
        image: "assets/image/first_onBoarding.png",
        body: "body2",
        title: "title2",
    ),
    BoardingModel(
        image: "assets/image/first_onBoarding.png",
        body: "body3",
        title: "title3",
    ),
  ] ;

  @override
  Widget build(BuildContext context) {
    void submit(){
      CashHelper.saveData(key: "onBoarding", val: true).then((value) {
        if(value){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>LoginScreen()
              ),
                  (route) => false);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(text: "SKIP" ,
              onPressed: (){
                submit() ;
              }
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controler,
                itemBuilder: (context,index) => itemsBuilding(items[index]),
                itemCount: items.length ,
                onPageChanged: (int index){
                  if(index == items.length-1){
                    setState(() {
                      islast = true ;
                    });
                  }
                  else {
                    setState(() {
                      islast = false ;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller:controler ,
                    count:  items.length,
                     effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,

                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast){
                      submit() ;
                    }
                    else {
                      controler.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget itemsBuilding(BoardingModel item) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image(
        image: AssetImage(item.image),
      ),
      const SizedBox(
        height: 25.0,
      ),
      Text(
          '${item.title}'
      ),
      const SizedBox(
        height: 25.0,
      ),
      Text(
          '${item.body}'
      ),
    ],
  ) ;
}
