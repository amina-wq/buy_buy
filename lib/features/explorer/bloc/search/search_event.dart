part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged({required this.category, required this.query});

  final Category category;
  final String query;

  @override
  List<Object> get props => super.props..addAll([category, query]);
}
