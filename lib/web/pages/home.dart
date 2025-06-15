import 'package:flutter/material.dart';
import '../../nav.dart';
import '../widgets/ContactForm.dart';
import '../../system/widgets/footer.dart';
import '../widgets/partners_section.dart';
import '../widgets/SubscriptionSection.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_app_section.dart';
import '../widgets/features_section.dart';
import '../widgets/image3scrol.dart';
import '../widgets/mobile_showcase.dart';
import '../widgets/nutif_form.dart';
import '../widgets/pricing_section.dart';
import '../widgets/section3.dart';
import '../widgets/section6.dart';
import '../widgets/users_section.dart';
import '../widgets/image_carousel.dart';
import '../widgets/stats_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _Page1State();
}

class _Page1State extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isImageHovered = false;
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          // Background color
          Container(color: theme.colorScheme.primary),
          // Background image with opacity
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.2),
                  BlendMode.dstIn,
                ),
              ),
            ),
          ),
          // Main content column
          Column(
            children: [
              // Fixed navigation bar
              Container(
                color: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: NavBar(scaffoldKey: _scaffoldKey),
              ),
              // Main scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 120),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isLargeScreen = constraints.maxWidth > 800;
                          return isLargeScreen
                              ? _buildLargeScreenHeader(theme)
                              : _buildSmallScreenHeader(theme);
                        },
                      ),
                      const SizedBox(height: 80),
                      FeaturesSection(),
                      const SizedBox(height: 50),
                      UsersSection(),
                      const SizedBox(height: 50),
                      Section3(),
                      const SizedBox(height: 50),
                      _buildCarouselSection(),
                      const SizedBox(height: 50),
                      MobileShowcase(),
                      const SizedBox(height: 50),
                      PricingSection(),
                      Section6(),
                      CustomAppSection(),
                      StatsSection(),
                      ImageCarousel3(),
                      PartnersSection(),
                      SubscriptionSection(),
                      ContactForm(),
                      NutifForm(),
                      FooterSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Header for large screens: image and text side by side
  Widget _buildLargeScreenHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Animated image
        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => _isImageHovered = true),
            onExit: (_) => setState(() => _isImageHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: _isImageHovered
                  ? Matrix4.translationValues(0, -10, 0)
                  : Matrix4.identity(),
              child: Image.asset(
                'assets/homme.png',
                fit: BoxFit.contain,
                height: 350,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Text content
        Expanded(child: _buildHeaderText(theme)),
      ],
    );
  }

  /// Header for small screens: text above image
  Widget _buildSmallScreenHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeaderText(theme),
        const SizedBox(height: 40),
        MouseRegion(
          onEnter: (_) => setState(() => _isImageHovered = true),
          onExit: (_) => setState(() => _isImageHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: _isImageHovered
                ? Matrix4.translationValues(0, -10, 0)
                : Matrix4.identity(),
            child: Image.asset(
              'assets/homme.png',
              fit: BoxFit.contain,
              height: 250,
            ),
          ),
        ),
      ],
    );
  }

  /// Main header text and call-to-action button
  Widget _buildHeaderText(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'نظام أهل القرآن',
          style: theme.textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 52,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'تسيير وتيسير التعليم القرآني',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          '.نظام أهل القرآن هو نظام سحابي متكامل .. يمكن بواسطته إنشاء بيئة رقمية',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          ' تربط بين مشرفي الحلقات ومدرسيها وطلابها وأولياء الأمور ، وذلك بمنحهم الأدوات الحديثة للارتقاء بحلقات القرآن',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        // Animated call-to-action button
        MouseRegion(
          onEnter: (_) => setState(() => _isButtonHovered = true),
          onExit: (_) => setState(() => _isButtonHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color:
                  _isButtonHovered ? Colors.white : theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.secondary,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            child: Text(
              'طلب نسخة',
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isButtonHovered
                    ? theme.colorScheme.secondary
                    : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Carousel section with padding
  Widget _buildCarouselSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ImageCarousel(),
    );
  }
}
