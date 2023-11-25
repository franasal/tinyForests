import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tinyforests/variables.dart';

// ListView Screen1
class ListViewContainer extends StatelessWidget {
  // variables
  // image -> für Bildpfad (Character.image)
  final String image;
  // name -> für Character.name
  final String name;

  // constructor
  // erweitert um: "required this.image" und "required this.name"
  const ListViewContainer({super.key, required this.image, required this.name});

  // methods
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h, // 30% der Screenhöhe
      width: 30.h, // 30% der Screenhöhe
      // FittedBox -> passt sich an die Größe des umgebenden Elements
      child: FittedBox(
        child: Container(
          height: 30.h, // 30% der Screenhöhe
          width: 30.h, // 30% der Screenhöhe
          margin: EdgeInsets.only(bottom: 5.h), // 5% der Screenhöhe
          decoration: BoxDecoration(
            image: DecorationImage(
                // ALT: image: AssetImage(avengersList[index]),
                image: AssetImage(image),
                fit: BoxFit.cover),
          ),
          // Column kann auch genutzt werden zur verticalen,
          // Positionierung eines einzelnen Elementes...
          child: Column(
            // ... mit Hilfe von mainAxisAlignment
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 30.h, // 30% der Screenhöhe
                color: Colors.black,
                child: Text(
                  name,
                  // style -> Formatierung des Textes via TextStyle-Widget
                  style: TextStyle(
                      color: Colors.white,
                      // sp -> scalable pixels - Textgröße abhängig von Screengröße
                      fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// + + + + + + + + + + + + GridView Screen2 und 3 + + + + + + + + + + + + +

class GridViewContainer extends StatelessWidget {
  // variables
  final String itemImage;
  final String itemText;
  // für eine individualisierbare Ausrichtung der Column (Text -> oben / unten)
  final MainAxisAlignment alignmentOfMain;

  // constructor
  const GridViewContainer(
      {super.key,
      required this.itemImage,
      required this.itemText,
      required this.alignmentOfMain});

  // methods
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // itemImage -> wird bei der Instanzierung/Erstellung im itemBuilder initialisiert
        image: DecorationImage(image: AssetImage(itemImage), fit: BoxFit.cover),
      ),
      child: Column(
        // alignmentOfMain -> wird bei der Instanzierung/Erstellung im itemBuilder initialisiert
        mainAxisAlignment: alignmentOfMain,
        children: [
          Container(
            width: double.infinity,
            color: Colors.black,
            child: Text(
              // itemText -> wird bei der Instanzierung/Erstellung im itemBuilder initialisiert
              itemText,
              // textAlign: TextAlign.center -> für horizontale Zentrierung des Textes
              textAlign: TextAlign.center,
              // style: TextStyle() -> style-formatierung des Textes
              style: TextStyle(
                // fontSize: 14.sp -> Schriftgröße
                fontSize: 14.sp,
                // color: Colors.white -> Textfarbe
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BottomNavigationBar bottomNaviBar(BuildContext context) {
  return BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    fixedColor: Colors.black,
    backgroundColor: Colors.white,
    items: [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: '',
        // backgroundColor: Colors.white
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.location_pin,
          color: Colors.black,
        ),
        label: 'Map',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'images/trees/Default.png',
          width: 28,
          height: 28,
          color: Colors.black,
        ),
        label: 'Trees',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.menu_book,
          color: Colors.black,
        ),
        label: 'Guide',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.black,
        ),
        label: 'More',
      ),
    ],
    // Handle navigation to different screens based on the selected item
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, startScreen);
          break;
        case 1:
          Navigator.pushNamed(context, mapScreen);
          break;
        case 2:
          Navigator.pushNamed(context, treesScreen);
          break;
        case 3:
          Navigator.pushNamed(context, guideScreen);
          break;
        case 4:
          AlertDialog(
            title: const Text("More Features"),
            content: const Text("comming soon..."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    startScreen,
                    (route) => false,
                  );
                },
                child: const Text("some page"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    startScreen,
                    (route) => false,
                  );
                },
                child: const Text("other page"),
              ),
            ],
          );
          break;
        // Add more cases for other items if needed
      }
    },
  );
}
