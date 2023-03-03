import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/logo.dart';
import 'package:genesis_robotec/app/core/components/stream_out.dart';
import 'package:genesis_robotec/app/core/components/w.dart';
import 'package:genesis_robotec/app/core/enum/app_page.dart';
import 'package:genesis_robotec/app/core/services/package_info_service.dart';
import 'package:genesis_robotec/app/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: true,
        child: Scaffold(
            key: _homeController.scaffoldHomeKey,
            endDrawer: SafeArea(
              child: _drawer(),
            ),
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              leading: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Logo(44),
              ),
              title: const Text(
                'Genesis Robotec',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 20,
                    color: Color(0xFF3B3B3B),
                    fontWeight: FontWeight.w500),
              ),
              actions: [
                InkWell(
                  onTap: () => _homeController.scaffoldHomeKey.currentState!.openEndDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.dehaze,
                      color: Colors.grey[800]!,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFFFFFF),
            body: StreamOut<AppPage>(
                stream: _homeController.pageStream.listen,
                child: (_, page) => PageView(
                      onPageChanged: (i) => _homeController.pageStream.add(AppPage.values[i]),
                      controller: _homeController.pageHomeController,
                      children: AppPage.values.map((e) => e.widget).toList(),
                    ))),
      ),
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: StreamOut<AppPage>(
          stream: _homeController.pageStream.listen,
          child: (_, page) => Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF02AD02).withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 5,
                            )
                          ]),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(24), child: const Logo(56)),
                          ),
                        ),
                        const W(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Genesis Robotec',
                              style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 22,
                                  color: Color(0xFF3B3B3B),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Kits Robóticos',
                                style: TextStyle(
                                    fontFamily: 'SpaceGrotesk',
                                    fontSize: 14,
                                    color: Colors.grey[600]!,
                                    fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 0.8,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      children: AppPage.values
                          .map(
                            (e) => Builder(builder: (context) {
                              bool selected = e == page;
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  if (!selected) {
                                    _homeController.pageHomeController.animateToPage(
                                        AppPage.values.indexOf(e),
                                        curve: Curves.ease,
                                        duration: const Duration(milliseconds: 300));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: Row(
                                    children: [
                                      Icon(
                                        e.icon,
                                        size: 26,
                                        color:
                                            selected ? const Color(0xFF02AD02) : Colors.grey[500],
                                      ),
                                      const W(24),
                                      Text(
                                        e.label,
                                        style: TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 16,
                                            color: selected
                                                ? const Color(0xFF02AD02)
                                                : Colors.grey[500],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                          .toList(),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Versão: ${PackageInfoService.version}',
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[500]!,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
