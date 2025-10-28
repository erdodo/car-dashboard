import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  bool _dippedBeam = false; //kısa far
  bool _fullBeam = false; //uzun far
  bool _fogLights = false; //sis farı

  int homeScreenIndex = 1;

  bool get dippedBeam => _dippedBeam;
  bool get fullBeam => _fullBeam;
  bool get fogLights => _fogLights;

  set dippedBeam(bool value) {
    _dippedBeam = value;
  }

  set fullBeam(bool value) {
    _fullBeam = value;
  }

  set fogLights(bool value) {
    _fogLights = value;
  }

  toggleDippedBeam(){
    _dippedBeam = !_dippedBeam;
    if(!_dippedBeam){
      _fullBeam = false;
    }
    notifyListeners();
  }

  toggleFullBeam(){
    _fullBeam = !_fullBeam;
    if(_fullBeam){
      _dippedBeam = true;
    }
    notifyListeners();
  }

  toggleFogLights(){
    _fogLights = !_fogLights;
    notifyListeners();
  }

  setHomeScreenIndex(int index){
    homeScreenIndex = index;
    notifyListeners();
  }
}
