import 'package:buy_buy/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required List<Product> products}) : _products = products, super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  final List<Product> _products;

  _onSearchQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    if (event.query.isEmpty) {
      emit(SearchInitial());
    } else {
      emit(SearchLoading());
      try {
        final filteredProducts =
            _products.where((product) => product.name.toLowerCase().contains(event.query.toLowerCase())).toList();
        emit(SearchLoaded(filteredProducts: filteredProducts));
      } catch (e) {
        emit(SearchFailure(error: e));
      }
    }
  }
}
