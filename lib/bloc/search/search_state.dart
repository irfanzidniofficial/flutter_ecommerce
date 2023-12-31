part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
   const factory SearchState.loading() = _Loading;
    const factory SearchState.success(ListProductResponseModel model) = _Success;
     const factory SearchState.error() = _Error;
}
