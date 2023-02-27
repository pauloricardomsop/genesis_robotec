import 'package:genesis_robotec/app/core/models/api_response_model.dart';
import 'package:rxdart/rxdart.dart';

class AppStream<T> {
  late final T t;
  AppStream() {
    controller = BehaviorSubject<T>();
  }

  AppStream.seeded(this.t) {
    controller = BehaviorSubject<T>.seeded(t);
  }

  late final BehaviorSubject<T> controller;
  void add(e) => controller.sink.add(e);
  Stream<T> get listen => controller.stream;
  T get value => controller.stream.value;
  void update() => controller.sink.add(controller.value);
}

class AppStreamResponse<T> {
  late final ApiResponse<T> t;
  late final BehaviorSubject<ApiResponse<T>> controller;
  void add(e) => controller.sink.add(e);
  void addInResponse(e) => controller.sink.add(ApiResponse.complete(e));
  Stream<ApiResponse<T>> get listen => controller.stream;
  T get value => controller.stream.value.data;

  bool get hasValidData => controller.hasValue && controller.value.hasData;

  AppStreamResponse() {
    controller = BehaviorSubject<ApiResponse<T>>();
  }

  AppStreamResponse.seeded(this.t) {
    controller = BehaviorSubject<ApiResponse<T>>.seeded(t);
  }
}
