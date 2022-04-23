import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_mania/cubits/countriesCubit.dart';
import 'package:cricket_mania/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  //
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<CountriesCubit>().fetchCountries();
    });
  }

  Widget _buildCountryContainer(Country country) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        width: MediaQuery.of(context).size.width * (0.2),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(country.imageUrl))),
                width: boxConstraints.maxWidth * (0.9),
                height: boxConstraints.maxWidth * (0.9),
              ),
              SizedBox(
                height: boxConstraints.maxHeight * (0.05),
              ),
              Expanded(
                child: Text(
                  country.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: country.rank == 1 ? Colors.red : null,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCountries() {
    return BlocBuilder<CountriesCubit, CountriesState>(
      builder: (context, state) {
        if (state is CountriesFetchSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * (0.135),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.countries.length,
                itemBuilder: (context, index) =>
                    _buildCountryContainer(state.countries[index])),
          );
        }
        if (state is CountriesFetchFailure) {
          return TextButton(
              onPressed: () {
                context.read<CountriesCubit>().fetchCountries();
              },
              child: Text(state.errorMessage));
        }
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildCountries(),
        ],
      ),
    );
  }
}
