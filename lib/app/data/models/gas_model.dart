// class Gas{
//   final String macAddress;
//   late double gasLevel;
//   late double leakageLevel;
//   late String nickName;
//   String ? description;
 
//   late bool isReadYesterday;

   

//   Gas(this.macAddress);  

// }


/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class GasInitialized {
    int? seconds;
    int? nanoseconds;

    GasInitialized({this.seconds, this.nanoseconds}); 

    GasInitialized.fromJson(Map<String, dynamic> json) {
        seconds = json['_seconds'];
        nanoseconds = json['_nanoseconds'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['_seconds'] = seconds;
        data['_nanoseconds'] = nanoseconds;
        return data;
    }
}

class MonthStats {
    double? jan;

    MonthStats({this.jan}); 

    MonthStats.fromJson(Map<String, dynamic> json) {
        jan = json['jan'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['jan'] = jan;
        return data;
    }
}

class Gas {
    String ? macAddress;
    double? gasLevel;
    bool? isReadYesterday;
    MonthStats? monthStats;
    GasInitialized? gasInitialized;
    double? gasWeight;
    bool? isAvailable;
    double? leakagelevel;
    WeekStats? weekStats;
    ThisWeek? thisWeek;

    Gas({this.gasLevel, this.isReadYesterday, this.monthStats, this.gasInitialized, this.gasWeight, this.isAvailable, this.leakagelevel, this.weekStats, this.thisWeek}); 

    Gas.fromJson(Map<String, dynamic> json,String this.macAddress) {
        gasLevel = json['gasLevel'];
        isReadYesterday = json['isReadYesterday'];
        // monthStats = json['monthStats'] != null ? MonthStats?.fromJson(json['monthStats']) : null;
        // gasInitialized = json['gasInitialized'] != null ? GasInitialized?.fromJson(json['gasInitialized']) : null;
        gasWeight = json['gasWeight'];
        isAvailable = json['isAvailable'];
        leakagelevel = json['leakagelevel'];
        // weekStats = json['weekStats'] != null ? WeekStats?.fromJson(json['weekStats']) : null;
        // thisWeek = json['thisWeek'] != null ? ThisWeek?.fromJson(json['thisWeek']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['gasLevel'] = gasLevel;
        data['isReadYesterday'] = isReadYesterday;
        data['monthStats'] = monthStats!.toJson();
        data['gasInitialized'] = gasInitialized!.toJson();
        data['gasWeight'] = gasWeight;
        data['isAvailable'] = isAvailable;
        data['leakagelevel'] = leakagelevel;
        data['weekStats'] = weekStats!.toJson();
        data['thisWeek'] = thisWeek!.toJson();
        return data;
    }
}

class ThisWeek {
    int? sat;
    int? wed;
    int? sun;
    int? fri;
    int? thu;
    int? tue;
    int? mon;

    ThisWeek({this.sat, this.wed, this.sun, this.fri, this.thu, this.tue, this.mon}); 

    ThisWeek.fromJson(Map<String, dynamic> json) {
        sat = json['sat'];
        wed = json['wed'];
        sun = json['sun'];
        fri = json['fri'];
        thu = json['thu'];
        tue = json['tue'];
        mon = json['mon'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['sat'] = sat;
        data['wed'] = wed;
        data['sun'] = sun;
        data['fri'] = fri;
        data['thu'] = thu;
        data['tue'] = tue;
        data['mon'] = mon;
        return data;
    }
}

class WeekStats {
    double? fri;
    int? sat;
    int? mon;
    int? thu;
    int? wed;
    int? sun;
    int? tue;

    WeekStats({this.fri, this.sat, this.mon, this.thu, this.wed, this.sun, this.tue}); 

    WeekStats.fromJson(Map<String, dynamic> json) {
        fri = json['fri'];
        sat = json['sat'];
        mon = json['mon'];
        thu = json['thu'];
        wed = json['wed'];
        sun = json['sun'];
        tue = json['tue'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['fri'] = fri;
        data['sat'] = sat;
        data['mon'] = mon;
        data['thu'] = thu;
        data['wed'] = wed;
        data['sun'] = sun;
        data['tue'] = tue;
        return data;
    }
}



class Gases {
   static Gas? activeGas ;
   static List<String> macAddresses = [];
  
}

