class CustomResponse {

  int statusCode;
  Map<String, dynamic> responseBody;
  bool error;
  Map<String, dynamic> errorMaps;

  CustomResponse({
    this.statusCode = 200,
    this.responseBody,
    this.error = false,
    this.errorMaps,
  });

  CustomResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMaps = json['errorMaps'];
  }
}