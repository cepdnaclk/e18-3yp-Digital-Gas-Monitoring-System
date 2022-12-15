class Gas{
  final String macAddress;
  late double _gasLevel;
  late double _leakageLevel;
 

  get gasLevel => _gasLevel;

  set gasLevel( value) => _gasLevel = value;

  get leakageLevel => _leakageLevel;

  set leakageLevel( value) => _leakageLevel = value;

  Gas(this.macAddress);

  
  
  


  

}



class Gases {
  static Gas? activeGas = Gas("0C:B8:15:EC:A8:94");
  static List<Gas>gasList = [];
  
}