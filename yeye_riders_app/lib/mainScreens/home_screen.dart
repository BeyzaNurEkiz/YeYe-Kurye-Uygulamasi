import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yeye_riders_app/mainScreens/earnings_screen.dart';
import 'package:yeye_riders_app/mainScreens/history_screen.dart';
import 'package:yeye_riders_app/mainScreens/new_orders_screen.dart';
import 'package:yeye_riders_app/mainScreens/parcel_in_progress_screen.dart';

import '../assistantMethods/get_current_location.dart';
import '../authentication/auth_screen.dart';
import '../global/global.dart';
import 'not_yet_delivered_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{

  Card makeDashboardItem(String title, IconData iconData, int index)
  {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
        child: Container(
          decoration: index==0 || index ==3 || index==4
              ? const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFF882A6),
                  Color(0xFFFFBED7),
                ],
              )
          )
              : const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFF882A6),
                  Color(0xFFFFBED7),
                ],
              )
          ),
          child: InkWell(
            onTap: ()
            {
              if(index==0)
              {
                //Yeni siparişler
                Navigator.push(context, MaterialPageRoute(builder: (c)=>NewOrdersScreen()));

              }
              if(index==1)
              {
                //Sipariş yola çıktı
                Navigator.push(context, MaterialPageRoute(builder: (c)=>ParcelInProgressScreen()));

              }
              if(index==2)
              {
                //Henüz teslim edilmedi
                Navigator.push(context, MaterialPageRoute(builder: (c)=>NotYetDeliveredScreen()));
              }
              if(index==3)
              {
                //Geçmiş
                Navigator.push(context, MaterialPageRoute(builder: (c)=>HistoryScreen()));

              }
              if(index==4)
              {
                //Toplam Kazanç
                Navigator.push(context, MaterialPageRoute(builder: (c)=>EarningsScreen()));

              }
              if(index==5)
              {
                //çıkış
                firebaseAuth.signOut().then((value)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>const AuthScreen()));
                });
              }
            },

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: [
                const SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      iconData,
                      size: 40,
                      color: Colors.black,
                    ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }

  @override
  void initState() {
    super.initState();

    UserLocation? uLocation = UserLocation();
    uLocation.getCurrentLocation();
    getPerParcelDeliveryAmount();
    getRiderPreviousEarnings();
  }

  getRiderPreviousEarnings()
  {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }


  getPerParcelDeliveryAmount()
  {
    FirebaseFirestore.instance.collection("perDelivery").doc("beyz1750")
        .get().then((snap)
    {
      perParcelDeliveryAmount= snap.data()!["amount"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF882A6),
                  Color(0xFFFFBED7),
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: Text(
          "Hosgeldin "+
          sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontFamily: "Signatra",
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("Yeni Siparişler", Icons.assignment, 0),
            makeDashboardItem("Yola Çıkan Siparişler", Icons.airport_shuttle, 1),
            makeDashboardItem("Teslim Edilmeyenler", Icons.location_history, 2),
            makeDashboardItem("Geçmiş", Icons.done_all, 3),
            makeDashboardItem("Toplam Kazanç", Icons.monetization_on, 4),
            makeDashboardItem("Çıkış Yap", Icons.logout, 5),
          ],
        ),
      ),
    );
  }
}
