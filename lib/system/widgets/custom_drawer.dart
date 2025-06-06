import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your controllers here
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/profile_controller.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/drawer_controller.dart'
    as mydrawer;

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final profileController = Get.find<ProfileController>();
  final drawerController = Get.find<mydrawer.DrawerController>();

  // Define your menu items here as a list
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.book, 'title': 'الخطط والمقررات'},
    {'icon': Icons.bar_chart, 'title': 'التقارير'},
    {'icon': Icons.insert_chart, 'title': 'الإحصائيات'},
    {
      'icon': Icons.folder,
      'title': 'إدارة المحتوى',
    },
    {'icon': Icons.language, 'title': 'الموقع الإلكتروني'},
    {'icon': Icons.campaign, 'title': 'الأخبار والإعلانات'},
    {'icon': Icons.menu_book, 'title': 'المكتبة'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      width: 280,
      backgroundColor: colorScheme.primaryContainer,
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Profile Section reactively from ProfileController
          Obx(() => CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(profileController.avatarPath.value),
              )),
          const SizedBox(height: 8),
          Obx(() => Text(
                profileController.userName.value,
                style: theme.textTheme.titleMedium,
              )),
          Obx(() => Text(
                profileController.userRole.value,
                style: theme.textTheme.bodyMedium,
              )),

          const Divider(height: 32),

          // Menu items dynamically built
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Obx(() => _buildMenuItem(
                      context,
                      item['icon'],
                      item['title'],
                      index,
                      highlight: item['highlight'] == true,
                      selected: drawerController.selectedIndex.value == index,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    int index, {
    bool highlight = false,
    bool selected = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final highlightColor = colorScheme.secondary;

    final color = selected
        ? highlightColor
        : (highlight
            ? highlightColor.withValues(alpha: 0.7)
            : colorScheme.onSurface);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(color: color),
      ),
      onTap: () {
        drawerController.changeSelectedIndex(index);
        // TODO: add your navigation logic here
      },
    );
  }
}
