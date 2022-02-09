class Result<T> {
  Result(this.success,
      {this.value, this.errorMessage, this.humanReadableError});

  bool? success;
  T? value;
  String? errorMessage;
  String? humanReadableError;
}
