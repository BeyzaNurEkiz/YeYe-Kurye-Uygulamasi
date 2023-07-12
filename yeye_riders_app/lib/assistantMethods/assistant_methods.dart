import 'package:cloud_firestore/cloud_firestore.dart';
import '../global/global.dart';


separateOrderItemIDs(orderIDs)
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = List<String>.from(orderIDs);

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\n Ürün kodu= " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\n Ürün listesi = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

separateItemIDs()
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\n Ürün kodu= " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\n Ürün listesi = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

separateOrderItemQuantities(orderIDs)
{
  List<String> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = List<String>.from(orderIDs);

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();

    //56557657

    List<String> listItemCharacter = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacter[1].toString());

    print("\n Ürün miktarı= " +  quanNumber.toString());

    separateItemQuantityList.add(quanNumber.toString());
  }

  print("\n Ürün miktar listesi = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}


separateItemQuantities()
{
  List<int> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();

    //56557657

    List<String> listItemCharacter = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacter[1].toString());

    print("\n Ürün miktarı= " +  quanNumber.toString());

    separateItemQuantityList.add(quanNumber);
  }

  print("\n Ürün miktar listesi = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}

clearCartNow(context)
{
  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value)
  {
    sharedPreferences!.setStringList("userCart", emptyList!);
  });
}
