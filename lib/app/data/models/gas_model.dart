class Gas{
  final String macAddress;
  late double _gasLevel;
  late double _leakageLevel;
  late String _nickName;
  String ? _description;
 

  get gasLevel => _gasLevel;

  set gasLevel( value) => _gasLevel = value;

  get leakageLevel => _leakageLevel;

  set leakageLevel( value) => _leakageLevel = value;


  String get nickName => _nickName ;

  set nickName (String value) {_nickName = value;}

  String ? get description => _description ?? '' ;

  set description (String ? value) {_description = value;}
   

  Gas(this.macAddress);  

}



class Gases {
  static Gas? activeGas = Gas("3A:82:D0:DA:90:8A");
  static List<Gas>gasList = [];
  
}