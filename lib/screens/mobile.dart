import 'package:flutter/material.dart';

import '../pages/mobile/mobile_homepage.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 10,
        ),
        child: _mobileBody(),
      ),
    );
  }

  _mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _topBar(),
        const Expanded(child: MobileHomePage()),
      ],
    );
  }

  _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          splashRadius: 24,
          onPressed: () {},
          icon: const Icon(Icons.menu_rounded),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: IconButton(
              splashRadius: 24,
              onPressed: () {},
              icon: const Icon(
                Icons.light_mode_outlined,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
