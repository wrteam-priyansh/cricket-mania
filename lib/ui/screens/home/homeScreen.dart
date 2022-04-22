import 'package:cricket_mania/cubits/countriesCubit.dart';
import 'package:cricket_mania/data/repositories/countryRepository.dart';
import 'package:cricket_mania/ui/screens/home/widgets/favoritePlayersContainer.dart';
import 'package:cricket_mania/ui/screens/home/widgets/homeContainer.dart';
import 'package:cricket_mania/ui/screens/home/widgets/profileContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Route<HomeScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<CountriesCubit>(
                  create: (context) => CountriesCubit(CountryRepository()),
                ),
                // BlocProvider<CountriesCubit>(
                //   create: (context) => CountriesCubit(CountryRepository()),
                // ),
              ],
              child: const HomeScreen(),
            ));
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelectedBottomNavIndex = 0;

  Widget _buildBottomNav() {
    return BottomNavigationBar(
        currentIndex: _currentSelectedBottomNavIndex,
        onTap: (index) {
          _currentSelectedBottomNavIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(label: "", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.account_box)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cricket Mania"),
      ),
      body: IndexedStack(
        index: _currentSelectedBottomNavIndex,
        children: const [
          HomeContainer(),
          FavoritePlayersContainer(),
          ProfileContainer(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }
}
