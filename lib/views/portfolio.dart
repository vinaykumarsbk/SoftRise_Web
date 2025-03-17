import 'package:flutter/material.dart';
import 'package:soft_rise/globals/app_assets.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';
import 'package:soft_rise/helper%20class/helper_class.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<Portfolio> {
  final onHoverEffect = Matrix4.identity()..scale(1.0);

  // Define only 3 images with their descriptions
  List<Map<String, String>> images = [
    {
      "image": AppAssets.work1,
      "title": "Kids Talent App",
      "description": "The app is a platform for kids aged to showcase their talents by uploading videos. Whether it's singing, dancing, art, karate, or coding, young users can easily share their skills with others in a fun and safe environment."
    },
    {
      "image": AppAssets.work2,
      "title": "KidScribe: A Creative Hub for Young Minds",
      "description": "KidScribe is a web application designed for kids to share their creativity and knowledge with the world. Whether you're a budding poet, aspiring author, or a young science expert, this platform allows you to publish your stories, novels, science articles, and blogs."
    },
    {
      "image": AppAssets.work3,
      "title": "OptiMaster: Performance Optimization Guide",
      "description": "OptiMaster is a comprehensive mobile application designed to provide quick tips and helpful guidelines for improving the performance of your devices, applications, and workflows. OptiMaster offers expert advice, step-by-step instructions, and actionable strategies."
    },
  ];

  int? tappedIndex; // This will keep track of the tapped item

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Utility.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 1),
        ],
      ),
      tablet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Utility.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 2),
        ],
      ),
      desktop: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Utility.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 3),
        ],
      ),
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.primaryLightColor,
      bgColor1: AppColors.appBarColor1,
      bgColor2: AppColors.appBarColor2,
    );
  }

  Widget buildProjectText() {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: RichText(
            text: TextSpan(
              text: 'Latest ',
              style: AppTextStyles.headingStyles(fontSize: 30.0),
              children: [
                TextSpan(
                  text: 'Projects',
                  style: AppTextStyles.headingStyles(
                    fontSize: 30,
                    color: AppColors.bgColor2,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProjectGridView({required int crossAxisCount}) {
    return GridView.builder(
      itemCount: images.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 380,  // Control the height of each grid item here
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        var image = images[index]["image"]!;
        var title = images[index]["title"]!;
        var description = images[index]["description"]!;
        return InkWell(
          onTap: () {
            setState(() {
              tappedIndex = index; // Set the tapped index
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 380, // Apply the fixed height to the container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,  // Try BoxFit.cover for better height fitting
                  ),
                ),
              ),
              // Display title and description when tapped
              Visibility(
                visible: tappedIndex == index,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  transform: tappedIndex == index ? onHoverEffect : null,
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.themeColor.withValues(alpha: 1.0),
                        AppColors.themeColor.withValues(alpha: 0.9),
                        AppColors.themeColor.withValues(alpha: 0.8),
                        AppColors.themeColor.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.montserratStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                      Utility.sizedBox(height: 15.0),
                      Text(
                        description, // Replaced the placeholder text with actual description
                        style: AppTextStyles.normalStyle(color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      Utility.sizedBox(height: 10.0),
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          AppAssets.share,
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
