

class DateParse {
  static DateTime? parse(String? date) {
    if(date == null)
    {
      return null;
    }
    List<String> dateParts = date.split('-');
    if(dateParts.length == 3)
    {
      return DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]), int.parse(dateParts[2]));
    }
    else if(dateParts.length == 2)
    {
      return DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]));
    }
    else if(dateParts.length == 1)
    {
      return DateTime(int.parse(dateParts[0]));
    }
    else
    {
      return null;
    }
  }
}