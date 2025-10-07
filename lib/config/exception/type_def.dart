import 'package:fpdart/fpdart.dart';
import 'package:smart_construction_calculator/config/exception/failures.dart';


typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;