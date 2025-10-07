import 'package:equatable/equatable.dart';

class PageCurrentCarsParams extends Equatable {
  final int page;

  const PageCurrentCarsParams({this.page = 1});

  @override
  List<Object> get props => [page];
}