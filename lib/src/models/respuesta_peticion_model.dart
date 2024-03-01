class RespuestaPeticion<T> {
  bool status;
  T? results;

  RespuestaPeticion({this.status = false, this.results});

  set resultsSet(T newValue) => this.results = newValue;
  set statusSet(bool newValue) => this.status = newValue;
}
