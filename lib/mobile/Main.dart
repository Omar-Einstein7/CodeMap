import 'package:codemap2/Model/values.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../Model/App_Theme.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List<String> listname = [
    "Recent",
    "mobile",
    "fornt end",
    "back end",
    "AI",
    "games",
  ];
  List<String> mobile = ["flutter", "kotlin", "react", "swift", "xamariin"];
  List<String> mobileimg = [
    "mobile/Flutter.png",
    "mobile/Kotlin.png",
    "mobile/React.png",
    "mobile/Swift.png",
    "mobile/Xamarin.png",
  ];
  List<String> frontend = ["Css", "Html", "JavaScript", "Angular-js", "Vue-js"];
  List<String> frontendimg = [
    "frontend/css3.png",
    "frontend/html-5.png",
    "frontend/6Javascript.png",
    "frontend/angularjs.png",
    "frontend/vue-js.png",
  ];
  List<String> backend = ["Php", "Java", "Sql", "Node js", "Python"];
  List<String> backendimg = [
    "backend/php.png",
    "backend/5Java.png",
    "backend/microsoft-sql-server.png",
    "backend/node-js.png",
    "backend/7Python.png",
  ];
  List<String> Ai = ["Java", "JavaScript", "Python", "C++"];
  List<String> Aiimg = [
    "ai/5Java.png",
    "ai/6Javascript.png",
    "ai/7Python.png",
    "ai/c++.png",
  ];
  List images = [
    "images2/c#.png",
    "images2/C++.png",
    "images2/css.png",
    "images2/html-5.png",
    "images2/5Java.png",
    "images2/6Javascript.png",
    "images2/7Python.png",
  ];
  List course = [
    "C #",
    "C + +",
    "C s s",
    "H T M L",
    "J a v a",
    "Java Script",
    "P y t h o n",
  ];
  List<Icon> icon = [
    Icon(BoxIcons.bxl_flutter),
    Icon(BoxIcons.bxl_c_plus_plus),
    Icon(BoxIcons.bxl_css3),
    Icon(BoxIcons.bxl_html5),
    Icon(BoxIcons.bxl_java),
    Icon(BoxIcons.bxl_javascript),
    Icon(BoxIcons.bxl_python),
  ];
  List routecourses = [
    "/coursec#",
    "/coursec",
    "/coursecss",
    "/coursehtml",
    "/coursejava",
    "/coursejs",
  ];
  List routemob = [
    "/courseflutter",
    "/coursekotlin",
    "/coursereact",
    "/courseswift",
    "/coursexamarin",
  ];

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData(),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontSize: 16,
                              color: themeProvider.isLightTheme
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                          ),
                          const Text(
                            "Omar Ahmed",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: themeProvider.isLightTheme
                              ? Colors.white
                              : const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          BoxIcons.bx_bell,
                          color: themeProvider.themeMode().switchcolor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Modernized Banner
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  height: height * 0.22,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeProvider.themeMode().switchcolor ??
                            AppColor.primary,
                        themeProvider.themeMode().switchcolor?.withOpacity(
                              0.7,
                            ) ??
                            AppColor.primary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (themeProvider.themeMode().switchcolor ??
                                    AppColor.primary)
                                .withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Opacity(
                          opacity: 0.2,
                          child: Icon(
                            BoxIcons.bxl_flutter,
                            size: 150,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "New Trend",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Mastering Flutter\nDevelopment",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        bottom: 15,
                        child: Image.asset(
                          "images2/flutter.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories Selector
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: listname.length,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          index == 0; // Defaulting to first for now
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? themeProvider.themeMode().switchcolor
                              : (themeProvider.isLightTheme
                                    ? Colors.white
                                    : const Color(0xFF333333)),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color:
                                        (themeProvider
                                                    .themeMode()
                                                    .switchcolor ??
                                                AppColor.primary)
                                            .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          listname[index].toUpperCase(),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (themeProvider.isLightTheme
                                      ? Colors.black87
                                      : Colors.white70),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Featured Courses Header
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                  child: Text(
                    "Featured Courses",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(
                  height: height * 0.32,
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Container(
                        width: width * 0.45,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: themeProvider.isLightTheme
                              ? Colors.white
                              : const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: themeProvider.isLightTheme
                                      ? Colors.grey[50]
                                      : const Color(0xFF3D3D3D),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                child: Text(
                                  course[index],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Recent Section Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Courses",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: themeProvider.themeMode().switchcolor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Modernized Recent List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: themeProvider.isLightTheme
                            ? Colors.white
                            : const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: themeProvider.isLightTheme
                                  ? Colors.grey[50]
                                  : const Color(0xFF3D3D3D),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "ELZERO WEB SCHOOL",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: themeProvider.isLightTheme
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  (themeProvider.themeMode().switchcolor ??
                                          AppColor.primary)
                                      .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              BoxIcons.bx_chevron_right,
                              color: themeProvider.themeMode().switchcolor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
