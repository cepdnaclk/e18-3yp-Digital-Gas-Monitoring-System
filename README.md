___
# DIGITAL GAS MONITORING SYSTEM
___

LPG is a fuel gas used in cooking appliances, and heating appliances. There were many issues with gas consumption in the most recent time period. The issues found as a whole are listed below.
* Available quantity of gas
* Gas leakage explosion
* Daily gas usage
* Consumption over the limit
* Struggle in easy refilling

### Solution Architecture
![image](https://user-images.githubusercontent.com/95094083/204203194-5b5e47a1-138a-475a-9889-5314d6789042.png)

The above diagram shows the solution architection of Gas level indicator system. The gas level inside the gas cylinder is going to be calculated by measuring the weight of the gas cylinder as follows.

**W<sub>gas</sub>=W<sub>EmptyCylinder</sub>+W<sub>liquid</sub>**

<img src="https://latex.codecogs.com/png.image?\inline&space;\dpi{110}\bg{white}Current&space;Level(%)=\frac{(Wgas-WEmptyCylinder)}{(Gas&space;Weight&space;set&space;by&space;User)}" title="https://latex.codecogs.com/png.image?\inline \dpi{110}\bg{white}Current Level(%)=\frac{(Wgas-WEmptyCylinder)}{(Gas Weight set by User)}" />

The last modified gas level reading will be transfered to firestore only when there is no change in readings in future for a specific amount of time. The user will be able to check the readings via our mobile application or via the lcd display that is being attached with our system.


### Data and Control Flow
![image](https://user-images.githubusercontent.com/95094083/204203325-5ba9f899-ed1a-4dba-b335-d2d99da205d1.png)

Above Data and control flow diagram shows the solution implementation of gas leakage detection and precaution system. Here, LPG gas leakage will be identified using MQ6 sensor. When a gas leakage circumstance is detected via our sensor we will alert our user by alarming the buzzer and also we will notify the registered user with our system via our mobile application. As a gas leakage precautionary system our system has an exhaust fan that will spread out the gas outside environment of room.

### 3D model of Gas level monitoring system
![image](https://user-images.githubusercontent.com/95094083/204203522-b9896378-0acf-4e6f-b42d-f61854d931e3.png)

### Sensors and actuators needed
* Gas sensor-MQ6
* Weight sensor
* ESP32-Wroom
* LCD Display 
* Piezo buzzer 

### Circuit Diagram
To achieve the overall functionality the circuit diagram should be designed as given below
![image](https://user-images.githubusercontent.com/95094083/204203765-5c2e0abe-bd20-43ad-9d6a-372a204420b7.png)

### Front-end technologies
Flutter to build Android Apps and Shortcuts to build iPhone Apps

### Back-end technologies
Cloud Functions for Firebase

### UI designs


https://user-images.githubusercontent.com/73964224/208391921-a7cccb9c-ebc8-4dfb-bc10-aa31ea062799.mp4



### Product development roadmap of week 01 - week 04
![image](https://user-images.githubusercontent.com/95094083/204204835-e30f008e-5f93-4dc1-bc82-8686bd5a76e6.png)

### Product development roadmap of week 05 - week 08
![image](https://user-images.githubusercontent.com/95094083/204204779-d91b8ca1-e968-4fe2-964e-e8afd8922ec1.png)

### Product development roadmap of week 09 - week 12
![image](https://user-images.githubusercontent.com/95094083/204204674-72af1380-a943-40f9-9f83-43df88070ec2.png)

### Product development roadmap of week 13 - week 16
![image](https://user-images.githubusercontent.com/95094083/204204735-6fa298ad-5b67-4834-aa77-d6eaccf0da00.png)

### Bill of materials

![bom](https://user-images.githubusercontent.com/73964224/204232440-44c6913c-02ec-44fc-919d-707c433c408d.PNG)

```
{
  "title": "Digital Gas Monitoring System",
  "team": [
    {
      "name": "Nishani K.",
      "email": "e18245@eng.pdn.ac.lk",
      "eNumber": "E/18/245"
    },
    {
      "name": "Subramanieam V.",
      "email": "e18340@eng.pdn.ac.lk",
      "eNumber": "E/18/340"
    },
    {
      "name": "Vilakshan V.",
      "email": "e18373@eng.pdn.ac.lk",
      "eNumber": "E/18/373"
    }
  ],
  "supervisors": [
    {
      "name": "Dr. Isuru Nawinne",
      "email": "isurunawinne@eng.pdn.ac.lk"
    },
    {
      "name": "Dr. Mahanama Wickramasinghe",
      "email": "mahanamaw@eng.pdn.ac.lk"
    }
  ],
  "tags": ["Mobile", "Embedded Systems"]
}
```
