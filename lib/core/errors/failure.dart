abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'خطایی در سرور رخ داده است']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'خطا در دسترسی به حافظه محلی']);
}
