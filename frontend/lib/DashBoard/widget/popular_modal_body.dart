import 'package:charles_warburton/DashBoard/widget/popular_games_result.dart';
import 'package:charles_warburton/MarketPlace/widget/custom_scroll_bar.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/dimensions.dart';
import '../models/popular_games_model.dart';
import '../requests/dashboard_requests.dart';

class PopularGamesModalBody extends StatefulWidget {
  const PopularGamesModalBody({Key? key}) : super(key: key);

  @override
  State<PopularGamesModalBody> createState() => _PopularGamesModalBodyState();
}

class _PopularGamesModalBodyState extends State<PopularGamesModalBody> {
  late PopularGamesModel? popularGamesModel;
  late bool hasPopularGamesModel = false;
  final ScrollController scrollController = ScrollController();
  _firstLoad() {
    GetPopularGames(
      callBackPopularGames: ((popularGames){
        setState(() {
          popularGamesModel = popularGames;
          hasPopularGamesModel = true;
        });
      }),
      callBackError: ((error){
        print(error);
      }),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstLoad();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return hasPopularGamesModel?
    CustomScrollBar(
      scrollController: scrollController,
      child: ListView.builder(
        controller: scrollController,
        itemCount: popularGamesModel!.results!.length,
        itemBuilder: ((BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: index+1!=popularGamesModel!.results!.length? Dimensions.paddingBottom:0),
            child: PopularGameResult(
              index: index+1,
              gameName: popularGamesModel!.results![index].name.toString(),
              image: popularGamesModel!.results![index].backgroundImage.toString(),
              rating: popularGamesModel!.results![index].rating!.toDouble()/popularGamesModel!.results![index].ratingTop!.toInt(),
              highestRating: popularGamesModel!.results![index].ratingTop!.toInt(),
              platforms: popularGamesModel!.results![index].platforms!,
            ),
          );
        }),
      ),
    )
        :
    Container();
  }
}
