import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';
import 'package:track_one/src/auth/auth_manager.dart';
import 'package:track_one/src/pages/user_detail_page.dart';
import 'package:track_one/src/services/service_locator.dart';
import 'package:track_one/src/widgets/user_list_card.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late TextEditingController textEditingController;

  bool loading = true;
  final ref = FirebaseDatabase.instance.ref('users');
  // void updateList(String value) {
  //   ///this is the function for filtering our list
  //   setState(() {
  //      textEditingController= ref.onValue
  //         .where((element) =>
  //         element.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
    textEditingController = TextEditingController();
    ref.onValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: [
          searchBar(),
          Container(
              height: MediaQuery.of(context).size.height * .75,
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                UserListCard(
                                    onTap: () async {
                                      await getIt<AuthManager>()
                                          .getTemperature();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDetailPage(
                                                    name: list[index]['name'],
                                                    lati: list[index]
                                                        ['lattitude'],
                                                    long: list[index]
                                                        ['longitude'],
                                                  )));
                                    },
                                    name: list[index]['name'],
                                    id: list[index]['id']),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Divider(
                                    color: AppTheme.colors.black,
                                    thickness: 1,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  })),
        ]),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, top: 20, bottom: 10, right: 30),
      child: Container(
        height: 47,
        width: 354,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppTheme.colors.searchText),
        child: TextFormField(
          cursorColor: AppTheme.colors.searchbutton,
          decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: AppTheme.colors.searchbutton,
              )),
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          controller: textEditingController,
          autofocus: false,
          onFieldSubmitted: (val) {},
          onChanged: (v) {
            EasyDebounce.debounce(
                'Search-Debounce', const Duration(milliseconds: 500), () {
              ref;
            });
          },
        ),
      ),
    );
  }
}
