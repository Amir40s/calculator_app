class AppExceptions implements Exception{
  final _message;
  final _prefix;

  AppExceptions([this._message , this._prefix]);

  @override
  String toString(){
    return'$_prefix $_message';
  }

}

class InternetExceptions extends AppExceptions{
  InternetExceptions([String? message]) : super(message, "No Internet");
}

class RequestTimeOutException extends AppExceptions{
  RequestTimeOutException([String? message]) : super (message, "Request Time Out ");
}

class ServerErrorException extends AppExceptions{
  ServerErrorException([String? message]) : super (message, 'Server Error');
}

class UrlNotFoundException extends AppExceptions{
  UrlNotFoundException([String? message]) : super (message, 'URL Not Found');
}