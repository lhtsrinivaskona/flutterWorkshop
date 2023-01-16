import 'package:flutter/material.dart';
import '../widgets/shimmer.dart';
import '../widgets/app_drawer.dart';
import '../providers/offers.dart';
import '../providers/offerList.dart';

class Offers extends StatefulWidget {
  static const routeName = '/offers';

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  bool isLoading = false;
  List<Offer> offerList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    offerList = List.of(allOffers);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
        actions: [IconButton(onPressed: loadData, icon: Icon(Icons.refresh))],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: isLoading ? 5 : offerList.length,
        itemBuilder: (ctx, index) {
          if (isLoading) {
            return buildShimmerEffect();
          } else {
            final offer = offerList[index];
            return buildOffers(offer);
          }
        },
      ),
    );
  }

  Widget buildOffers(Offer offer) => ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(offer.urlImage),
        ),
        title: Text(
          offer.title,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          offer.description,
          style: TextStyle(fontSize: 14),
        ),
      );

  Widget buildShimmerEffect() => ListTile(
        leading: ShimmerWidget.circular(
          width: 64,
          height: 64,
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 16,
          ),
        ),
        subtitle: ShimmerWidget.rectangular(height: 14),
      );
}
