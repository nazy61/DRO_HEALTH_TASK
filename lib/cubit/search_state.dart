part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];

  get isSearching => null;
  get isSearchingByCategory => null;
}

class SearchInitial extends SearchState {
  @override
  final bool isSearching;
  @override
  final bool isSearchingByCategory;
  const SearchInitial(this.isSearching, this.isSearchingByCategory);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchInitial &&
        other.isSearching == isSearching &&
        other.isSearchingByCategory == isSearchingByCategory;
  }

  @override
  int get hashCode => isSearching.hashCode;
}

class SearchChanged extends SearchState {
  @override
  final bool isSearching;
  @override
  final bool isSearchingByCategory;
  const SearchChanged(this.isSearching, this.isSearchingByCategory);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchChanged &&
        other.isSearching == isSearching &&
        other.isSearchingByCategory == isSearchingByCategory;
  }

  @override
  int get hashCode => isSearching.hashCode;
}
