import 'package:flutter/material.dart';
import 'package:shop_app/modules/Loginscreen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
   final String image;
   final String title;
   final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List <BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/easyshoping.png',
        title: 'Purchase your item online',
        body: 'Simply browse an extensive selection of the best hot sale products and find one that suits you! You can also filter out items that offer free shipping to narrow down your search for hot sale products! The selection of hot sale is always getting an update.'),
    BoardingModel(
        image: 'assets/images/quickdelivery.png',
        title: 'Fast delivery',
        body: 'Use our fastest possible delivery option to get your most urgent international shipments delivered intact and on time.'),
    BoardingModel(
        image: 'assets/images/securepayment.png',
        title: 'Make the payment',
        body: 'We support Visa debit/credit cards and MasterCard credit cards. You can also use prepaid and virtual cards, which have the great advantage of being more secure, since they only allow you to spend the amount you have deposited on them previously.'),
  ];

   bool isLast = false;
   IconData nextIcon = Icons.arrow_forward;
  var boardController = PageController();

  void finishOnBoarding() 
  {
    CacheHelper.saveData(key: 'onBoardingScreen', value: true).then((value) {
      navigateAndFinish(context, LoginScreen());
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == 2) {
                        setState(() {
                          isLast = true;
                          nextIcon = Icons.done;
                        });
                      }
                      else
                        setState(() {
                          isLast = false;
                          nextIcon = Icons.arrow_forward;
                        });
                    },
                    controller: boardController,
                    physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                      itemCount: boarding.length,

                  ),
                ),
                SizedBox(
                  height:40.0 ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                        controller: boardController,
                        count: boarding.length,
                      effect: ScaleEffect(
                          activeDotColor: defaultColor,  //HexColor('2BD596'),
                        dotWidth: 12,
                        dotHeight: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    TextButton(onPressed: ()
                    {
                      finishOnBoarding();
                    },
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                            color: Colors.black45,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Spacer(),// بياخد كل المسافة اللي فالنص
                    FloatingActionButton(
                      mini: true,
                      onPressed: () {
                      if (isLast) {
                        finishOnBoarding();
                      }
                      else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastOutSlowIn

                        );
                      }
                    },
                      child: Icon(
                          nextIcon,
                      ),)
      ]
                ),
              ],
            ),
          )

      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Expanded(
        child: Image(
          image: AssetImage(
            '${model.image}',
        ),
        ),
      ),
      Text('${model.title}',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24.0
        ),),
      SizedBox(height: 14.0,),
      Text('${model.body}',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0
        ),),
      SizedBox(height: 14.0,),
    ],
  );
}
