import 'package:dartz/dartz.dart';

typedef ApiFuture<T> = Future<Either<T, FailureResponse>>;
typedef ApiStream<T> = Stream<Either<T, FailureResponse>>;


class FailureResponse<T> {
  final String message;
  final T? data;

  const FailureResponse(this.message, {this.data});
}

class InternetFailureResponse<T> extends FailureResponse<T> {
  const InternetFailureResponse() : super("No internet connection");
}

class OtherFailureResponse<T> extends FailureResponse<T> {
  final Object e;

  OtherFailureResponse(this.e) : super("An error occurred");
}
