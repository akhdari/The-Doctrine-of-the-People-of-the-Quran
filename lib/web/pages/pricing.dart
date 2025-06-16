import 'package:flutter/material.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/helpers/nav.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/helpers/custom_drawer.dart';
import '../../system/widgets/footer.dart';
import '../widgets/custom_app_section.dart';
import '../widgets/pricing_content.dart';
import '../widgets/pricing_section.dart';
import '../widgets/section6.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  _PricingPageState createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstIn,
                ),
              ),
            ),
          ),
          // Main content column
          Column(
            children: [
              // AppBar section
              Container(
                color: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: NavBar(scaffoldKey: _scaffoldKey),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      _buildHeader(theme),
                      const SizedBox(height: 50),
                      PricingContent(),
                      PricingSection(),
                      Section6(),
                      CustomAppSection(),
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

  /// Builds the header section with title and subtitle.
  Widget _buildHeader(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'الأسعار,',
          style: theme.textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 52,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'الأسعار,/الرئيسية',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
