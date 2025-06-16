import 'package:flutter/material.dart';
import '../../system/widgets/footer.dart';
import '../widgets/features_section.dart';
import '../widgets/section3.dart';
import '/system/widgets/nav.dart';
import '/system/widgets/custom_drawer.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
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
                image: const AssetImage('assets/back.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstIn,
                ),
              ),
            ),
          ),
          // Main content
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
                      const FeaturesSection(),
                      const Section3(),
                      const FooterSection(),
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

  /// Builds the header section with the page title and subtitle.
  Widget _buildHeader(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'خصائص النظام',
          style: theme.textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 52,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'خصائص النظام/الرئيسية',
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
