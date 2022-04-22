import 'package:cricket_mania/data/models/country.dart';
import 'package:cricket_mania/data/repositories/countryRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CountriesState extends Equatable {}

class CountriesInitial extends CountriesState {
  @override
  List<Object?> get props => [];
}

class CountriesFetchInProgress extends CountriesState {
  @override
  List<Object?> get props => [];
}

class CountriesFetchSuccess extends CountriesState {
  final List<Country> countries;

  CountriesFetchSuccess(this.countries);
  @override
  List<Object?> get props => [countries];
}

class CountriesFetchFailure extends CountriesState {
  final String errorMessage;

  CountriesFetchFailure(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class CountriesCubit extends Cubit<CountriesState> {
  final CountryRepository countryRepository;

  CountriesCubit(this.countryRepository) : super(CountriesInitial());

  void fetchCountries() {
    emit(CountriesFetchInProgress());
    countryRepository
        .fetchCountries()
        .then((value) => emit(CountriesFetchSuccess(value)))
        .catchError((e) {
      emit(CountriesFetchFailure(e.toString()));
    });
  }
}
