
class GptApi {
  GptApi._();
  String APIKEY = '';

  static final GptApi instance = GptApi._();


  void setKey(String key){
    APIKEY = key;
  }
}