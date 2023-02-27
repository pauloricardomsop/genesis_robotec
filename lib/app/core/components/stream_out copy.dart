import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/loading.dart';

class StreamOutResponse<ApiResponse, T> extends StatelessWidget {
  final Stream<ApiResponse> stream;
  final Widget Function(BuildContext context, T data) child;
  final Function? preFunction;
  final bool condition;
  final Function? request;

  const StreamOutResponse({
    Key? key,
    required this.stream,
    required this.child,
    this.preFunction,
    this.condition = true,
    this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition && preFunction != null) preFunction!.call();
    return StreamBuilder<ApiResponse>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
          dynamic response = snapshot.requireData;
          if (response.hasData) {
            return child(_, response.data);
          } else {
            return const Text('erro');
            // return ErrorHttpWidget(response.error!, request: request);
          }
        } else {
          return const Loading();
        }
      },
    );
  }
}

class StreamOut<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) child;
  final Function? preFunction;
  final bool condition;
  final Function? request;
  final Widget? loading;

  const StreamOut({
    Key? key,
    required this.stream,
    required this.child,
    this.preFunction,
    this.condition = true,
    this.request,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition && preFunction != null) preFunction!.call();
    return StreamBuilder<T>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
          return child(_, snapshot.requireData);
        } else {
          return loading ?? const LoadingStacked();
        }
      },
    );
  }
}
