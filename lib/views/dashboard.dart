import 'package:flutter/material.dart';
import 'package:soft_rise/views/about_us.dart';
import 'package:soft_rise/views/contact_us.dart';
import 'package:soft_rise/views/footer_class.dart';
import 'package:soft_rise/views/home_page.dart';
import 'package:soft_rise/views/our_services.dart';
import 'package:soft_rise/views/portfolio.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/utility.dart';
import 'package:soft_rise/globals/app_text_styles.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();

  final List<String> menuItems = [
    'Home',
    'About',
    'Services',
    'Portfolio',
    'Contact',
  ];

  int menuIndex = 0; // Tracks which menu item is highlighted
  final List<GlobalKey> _keys = List.generate(6, (index) => GlobalKey());
  late final List<Widget> screensList;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scrollController.addListener(_scrollListener);

    // Setup the list of screens.
    screensList = [
      HomePage(onScrollToContact: () => scrollTo(index: 4)),
      AboutUs(),
      OurServices(),
      Portfolio(),
      ContactUs(),
      FooterClass(),
    ];

    // Start the animation initially
    _controller.forward();
  }

  void _scrollListener() {
    double offset = _scrollController.position.pixels;

    if (offset < 300) {
      setState(() {
        menuIndex = 0; // Home section
      });
    } else if (offset >= 300 && offset < 800) {
      setState(() {
        menuIndex = 1; // About section
      });
    } else if (offset >= 800 && offset < 1300) {
      setState(() {
        menuIndex = 2; // Services section
      });
    } else if (offset >= 1300 && offset < 1800) {
      setState(() {
        menuIndex = 3; // Portfolio section
      });
    } else if (offset >= 1800) {
      setState(() {
        menuIndex = 4; // Contact section
      });
    }
  }

  Future<void> scrollTo({required int index}) async {
    try {
      final context = _keys[index].currentContext;
      if (context != null) {
        await Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 2),
          curve: Curves.fastLinearToSlowEaseIn,
        );
        setState(() {
          menuIndex = index;
        });
      }
    } catch (e) {
      debugPrint("Error during scroll: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(size),
      floatingActionButton: _buildFloatingActionButton(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(Size size) {
    return AppBar(
      flexibleSpace: _buildAppBarGradient(),
      toolbarHeight: 90,
      titleSpacing: 40,
      elevation: 0,
      title: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 768) {
            return _buildMobileNavBar(size);
          } else {
            return _buildDesktopNavBar();
          }
        },
      ),
    );
  }

  Container _buildAppBarGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.appBarColor,
            AppColors.appBarColor1,
            AppColors.appBarColor2
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0, 0.0],
          tileMode: TileMode.clamp,
        ),
      ),
    );
  }

  Row _buildMobileNavBar(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('SoftRise', style: AppTextStyles.montserratStyle(color: Colors.white)),
        const Spacer(),
        PopupMenuButton(
          icon: Icon(Icons.menu_sharp, size: 32, color: Colors.white),
          color: AppColors.bgColor2,
          position: PopupMenuPosition.under,
          constraints: BoxConstraints.tightFor(width: size.width * 0.9),
          itemBuilder: (BuildContext context) => menuItems
              .asMap()
              .entries
              .map(
                (e) => PopupMenuItem(
              textStyle: AppTextStyles.headerTextStyle(),
              onTap: () {
                scrollTo(index: e.key);
              },
              child: Text(e.value),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Row _buildDesktopNavBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('SoftRise', style: AppTextStyles.montserratStyle(color: Colors.white)),
        const Spacer(),
        SizedBox(
          height: 30,
          child: ListView.builder(
            itemCount: menuItems.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => scrollTo(index: index),
                borderRadius: BorderRadius.circular(100),
                onHover: (value) {
                  setState(() {
                    menuIndex = value ? index : 0;
                  });
                },
                child: buildNavBarAnimatedContainer(index, menuIndex == index),
              );
            },
          ),
        ),
        Utility.sizedBox(width: 30),
      ],
    );
  }

  ScaleTransition _buildFloatingActionButton() {
    // If we are on the Home section (index 0), hide the button by returning SizedBox.shrink()
    if (menuIndex == 0) {
      return ScaleTransition(
        scale: _animation,
        child: const SizedBox.shrink(), // This hides the button
      );
    }

    return ScaleTransition(
      scale: _animation,
      child: FloatingActionButton(
        onPressed: () => scrollTo(index: 0),
        child: Icon(Icons.arrow_upward, color: AppColors.orange),
      ),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: List.generate(screensList.length, (index) {
          return Container(
            key: _keys[index],
            child: screensList[index],
          );
        }),
      ),
    );
  }

  AnimatedContainer buildNavBarAnimatedContainer(int index, bool hover) {
    return AnimatedContainer(
      alignment: Alignment.center,
      width: hover ? 120 : 115,
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(hover ? 1.1 : 1.0), // Correct Matrix4 usage
      child: Row(
        children: [
          Icon(
            _getIconForMenu(index),
            size: hover ? 30 : 24,
            color: menuIndex == index ? AppColors.bgColor2 : Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            menuItems[index],
            style: AppTextStyles.headerTextStyle(
              color: menuIndex == index ? AppColors.bgColor2 : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForMenu(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.info;
      case 2:
        return Icons.build;
      case 3:
        return Icons.work;
      case 4:
        return Icons.contact_mail;
      default:
        return Icons.home;
    }
  }
}
