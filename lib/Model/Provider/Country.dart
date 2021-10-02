
import 'package:flutter/cupertino.dart';

class CountryPrv extends ChangeNotifier
{
  String code ='Eg';

  countryChange(value)
  {
    code = value;
    notifyListeners();
  }
}