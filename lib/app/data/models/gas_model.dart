class Gas{
  final String macAddress;
  late String _gasLevel;
  late String _leakageLevel;
 

  get gasLevel => _gasLevel;

  set gasLevel( value) => _gasLevel = value;

  get leakageLevel => _leakageLevel;

  set leakageLevel( value) => _leakageLevel = value;

  Gas(this.macAddress);
  
  


  

}



class Gases {
  static Gas? activeGas;
  static List<Gas>gasList = [];
  
}