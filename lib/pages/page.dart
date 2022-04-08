import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable()
abstract class PageConfig extends Equatable {
  late final RIMOPage page = createPage();
  RIMOPage createPage();

  @override
  List<Object?> get props => [];
}

abstract class RIMOPage<T extends PageConfig> extends Page<T> {
  const RIMOPage(this.routePath);
  final T routePath;

  Widget build(BuildContext context);

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Scaffold(body: Center(child: build(context)));
      },
    );
  }
}
