import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _clear = Object();

class AddressState{
  final List<String> cities;
  final List<String> filteredCities;
  final List<String> streets;
  final List<String> filteredStreets;
  final String? selectedCity;
  final String? selectedStreet;
  final bool isLoading;

  AddressState({
    this.cities = const [],
    this.filteredCities = const [],
    this.streets = const [],
    this.filteredStreets = const [],
    this.selectedCity,
    this.selectedStreet,
    this.isLoading = false,
  });


  AddressState copyWith({
  List<String>? cities,
  List<String>? filteredCities,
  List<String>? streets,
  List<String>? filteredStreets,
  Object? selectedCity = _clear,
  Object? selectedStreet = _clear,
  bool? isLoading,
}) {
  return AddressState(
    cities: cities ?? this.cities,
    filteredCities: filteredCities ?? this.filteredCities,
    streets: streets ?? this.streets,
    filteredStreets: filteredStreets ?? this.filteredStreets,
    selectedCity: selectedCity == _clear ? this.selectedCity : selectedCity as String?,
    selectedStreet: selectedStreet == _clear ? this.selectedStreet : selectedStreet as String?,
    isLoading: isLoading ?? this.isLoading,
  );
}
}

class AddressCubit extends Cubit<AddressState>{
  final SupabaseClient client;

  AddressCubit(this.client) : super(AddressState()){
    fetchCities();
  }

  Future<void> fetchCities() async {
    emit(state.copyWith(isLoading: true));
    final List<dynamic> data = await client
      .from('cities')
      .select('name')
      .order('name');
    final names = data.map((e) => e['name'] as String).toList();
  
    emit(state.copyWith(cities: names,filteredCities: names, isLoading: false));
  }

  void filterCities(String query){
    final filtered = state.cities.where((c) => c.toLowerCase()
    .contains(query.toLowerCase())).toList();
    emit(state.copyWith(filteredCities: filtered));
  }

  Future<void> selectCity(String cityName) async {
    emit(state.copyWith(
      selectedCity: cityName,
      selectedStreet: null,
      streets: [],
      filteredStreets: [],
      isLoading: true,
    ));

    try{
      final List<dynamic> data = await client
      .from('streets')
      .select('name, cities!inner(name)')
      .eq('cities.name', cityName)
      .order('name');

    final streetNames = data.map((e) => e['name'] as String).toList();
   
    emit(state.copyWith(
      streets: streetNames,
      filteredStreets: streetNames,
      isLoading: false
    ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }

    
  }

  void filterStreets(String query){
    final filtered = state.streets.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList();
    emit(state.copyWith(filteredStreets: filtered));
  }

  void selectedStreet(String streetName) => emit(state.copyWith(selectedStreet: streetName));
}
