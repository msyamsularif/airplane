class ApiReturnValue<T> {
  final T? value;
  final String? message;

  ApiReturnValue({
    this.value,
    this.message,
  });
}