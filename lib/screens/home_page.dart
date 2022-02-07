import 'package:a_new_project_in_flutter/components/my_controllers.dart';
import 'package:a_new_project_in_flutter/utils/my_colors.dart';
import 'package:a_new_project_in_flutter/utils/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: MyColors.black),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Image.asset(
                  'images/app_logo.png',
                  scale: 0.90,
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(),
      body: Container(
        color: MyColors.white,
        child: Column(
          children: [
            Divider(height: 5),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: MyColors.searchFieldBorder),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("images/search_icon_red.svg"),
                      ),
                      hintText: MyStrings.searchFunTone,
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      fillColor: MyColors.searchFieldBg,
                      filled: true)),
            ),
          ],
        ),
      ),
    );
  }
}
