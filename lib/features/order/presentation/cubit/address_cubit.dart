import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressState{
  final List<String> cities;
  final List<String> streets;
  final String? selectedCity;
  final String? selectedStreet;
  final bool isLoading;

  AddressState({
    this.cities = const [],
    this.streets = const [],
    this.selectedCity,
    this.selectedStreet,
    this.isLoading = false,
  });

  AddressState copyWith({
    List<String>? cities,
    List<String>? streets,
    String? selectedCity,
    String? selectedStreet,
    bool? isLoading,
  }) {
    return AddressState(
      cities: cities ?? this.cities,
      streets: streets ?? this.streets,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedStreet: selectedStreet ?? this.selectedStreet,
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
      .select('name');
    final cityNames = data.map((e) => e['name'] as String).toList();
    emit(state.copyWith(cities: cityNames, isLoading: false));
  }

  Future<void> onCityChanged(String cityName) async {
    emit(state.copyWith(
      selectedCity: cityName,
      selectedStreet: null,
      streets: [],
      isLoading: true,
    ));

    final List<dynamic> data = await client
      .from('streets')
      .select('name, cities!inner(name)')
      .eq('cities.name', cityName);

    final streetNames = data.map((e) => e['name'] as String).toList();
    emit(state.copyWith(
      streets: streetNames,
      isLoading: false
    ));
  }

  void onStreetChanged(String streetName){
    emit(state.copyWith(selectedStreet: streetName));
  }
}
