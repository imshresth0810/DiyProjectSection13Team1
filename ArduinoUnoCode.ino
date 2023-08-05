/* Code for Arduino Uno */
#include <SoftwareSerial.h>
#include <Servo.h>
SoftwareSerial nodemcu(2, 3);
int parking1_slot1_ir_s = 4;
int parking1_slot2_ir_s = 5;
int parking1_slot3_ir_s = 6;
int parking1_slot4_ir_s = 7;
const int analogInPin0 = A0;
// const int analogInPin1 = A1;
int sensorValue1 = 0;
int sensorValue2 = 0;
int servoPin1 = 8;
int servoPin2 = 9;
int i = 0;
Servo servo1;
Servo servo2;
String sensor1;
String sensor2;
String sensor3;
String sensor4;
String cdata = "";
void setup()
{
    Serial.begin(9600);
    nodemcu.begin(9600);
    pinMode(parking1_slot1_ir_s, INPUT);
    pinMode(parking1_slot2_ir_s, INPUT);
    pinMode(parking1_slot3_ir_s, INPUT);
    pinMode(parking1_slot4_ir_s, INPUT);
    servo1.attach(servoPin1);
    servo2.attach(servoPin2);
}
void loop()
{
    sensorValue1 = analogRead(analogInPin0);
    if (sensorValue1 < 600)
    {
        for (int i = 0; i <= 90; i++)
        {
            servo1.write(i);
            delay(30);
        }
    }
    servo1.write(i);
    sensorValue2 = analogRead(analogInPin1);
    if (sensorValue2 < 600)
    {
        for (int i = 0; i <= 90; i++)
        {
            servo2.write(i);
            delay(30);
        }
    }
    servo2.write(i);
    p1slot1();
    p1slot2();
    p1slot3();
    p1slot4();
    cdata = cdata + sensor1 + "," + sensor2 + "," + sensor3 + "," + sensor4 + ",";
    Serial.println(cdata);
    nodemcu.println(cdata);
    delay(3000); // 100 milli seconds
    cdata = "";
    digitalWrite(parking1_slot1_ir_s, HIGH);
    digitalWrite(parking1_slot2_ir_s, HIGH);
    digitalWrite(parking1_slot3_ir_s, HIGH);
    digitalWrite(parking1_slot4_ir_s, HIGH);
}
void p1slot1()
{
    if (digitalRead(parking1_slot1_ir_s) == LOW)
    {
        sensor1 = "255";
        delay(200);
    }
    if (digitalRead(parking1_slot1_ir_s) == HIGH)
    {
        sensor1 = "0";
        delay(200);
    }
}
void p1slot2()
{
    if (digitalRead(parking1_slot2_ir_s) == LOW)
    {
        sensor2 = "255";
        delay(200);
    }
    if (digitalRead(parking1_slot2_ir_s) == HIGH)
    {
        sensor2 = "0";
        delay(200);
    }
}
void p1slot3()
{
    if (digitalRead(parking1_slot3_ir_s) == LOW)
    {
        sensor3 = "255";
        delay(200);
    }
    if (digitalRead(parking1_slot3_ir_s) == HIGH)
    {
        sensor3 = "0";
        delay(200);
    }
}
void p1slot4()
{
    if (digitalRead(parking2_slot1_ir_s) == LOW)
    {
        sensor4 = "255";
        delay(200);
    }
    if (digitalRead(parking2_slot1_ir_s) == HIGH)
    {
        sensor4 = "0";
        delay(200);
    }
}