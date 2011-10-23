import processing.serial.*;
import cc.arduino.*;
import eeml.*;
import pachuino.*;
Arduino arduino;
float lightLevel;
float lastUpdate; 
DataOut dOut;
Pachuino p;

void setup() 
{
  size(700, 500);
  background(0);

 // printLn(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);

  dOut = new DataOut(this, 5210);

  dOut = new DataOut(this, "http://www.pachube.com/api/37358.xml", "yXQ15tdvOqkBaR7RN9FTiYzuWF6o6LcdDYYDNeKH4bE");

  dOut.addData(1, "test, Sensor, Okay");

  
}







//p = new Pachuino(this, Arduino.list()[0], 57600);    
//p.manualUpdate("http://www.pachube.com/api/37358.xml"); // change URL -- this is the feed you want to update
//  p.setKey("yXQ15tdvOqkBaR7RN9FTiYzuWF6o6LcdDYYDNeKH4bE");    


// local sensors    
//p.addLocalSensor("analog", 0, "Sensor");


void draw()
{
  lightLevel = arduino.analogRead(0);

  if ((millis() - lastUpdate) > 10000) {
    println(lightLevel);
    println("ready to PUT: ");
    dOut.update(0, lightLevel); 
    int response = dOut.updatePachube(); 
    println(response); 
    lastUpdate = millis();

    if (lightLevel > 255) {
      fill (4,253,20);
      rect(300, 200, 250, 250);
    }
    else if (lightLevel < 255) {
      fill(62,62,62);
      rect(300, 200, 250, 250);
    }
  }
}

