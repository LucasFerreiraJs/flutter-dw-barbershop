sealed class Either<E extends Exception, S> {}

class Failure<E extends Exception, S> extends Either<E, S> {
  final E exception;
  Failure(this.exception);
}

class Success<E extends Exception, S> extends Either<E, S> {
  final Success value;
  Success(this.value);
}