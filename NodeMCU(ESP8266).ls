/* Code for NodeMCU(ESP8266 WIFI Module) */
#include <ArduinoWiFiServer.h>
#include <BearSSLHelpers.h>
#include <CertStoreBearSSL.h>
#include <ESP8266WiFi.h>
#include <ESP8266WiFiAP.h>
#include <ESP8266WiFiGeneric.h>
#include <ESP8266WiFiGratuitous.h>
#include <ESP8266WiFiMulti.h>
#include <ESP8266WiFiScan.h>
#include <ESP8266WiFiSTA.h>
#include <ESP8266WiFiType.h>
#include <WiFiClient.h>
#include <WiFiClientSecure.h>
#include <WiFiClientSecureBearSSL.h>
#include <WiFiServer.h>
#include <WiFiServerSecure.h>
#include <WiFiServerSecureBearSSL.h>
#include <WiFiUdp.h>
#include <SimpleTimer.h>
#include <Blynk.h>
#define BLYNK_PRINT Serial
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#include <SoftwareSerial.h>
#include <SimpleTimer.h>
char auth[] = "7-ibe46cmM-hGXhFYbFKkKMFSDbffN42"; // Blynk Token
char ssid[] = "Gaurav08";                         // Our Wifi(Local Area Network)
char pass[] = "123456789";                        // Wifi Password
SimpleTimer timer;
String myString;
char rdata;
int firstVal, secondVal, thirdVal;
int led1, led2, led3, led4;
void myTimerEvent()
{
    Blynk.virtualWrite(V1, millis() / 1000);
}
void setup()
{
    Serial.begin(9600);
    Blynk.begin(auth, ssid, pass);
    timer.setInterval(1000L, sensorvalue1);
    timer.setInterval(1000L, sensorvalue2);
    timer.setInterval(1000L, sensorvalue3);
    timer.setInterval(1000L, sensorvalue4);
}
void loop()
{
    if (Serial.available() == 0)
    {
        Blynk.run();
        timer.run();
    }
    if (Serial.available() > 0)
    {
        rdata = Serial.read();
        myString = myString + rdata;
        if (rdata == '\n')
        {
            Serial.println(myString);
            String l = getValue(myString, ',', 0);
            String m = getValue(myString, ',', 1);
            String n = getValue(myString, ',', 2);
            String o = getValue(myString, ',', 3);
            led1 = l.toInt();
            led2 = m.toInt();
            led3 = n.toInt();
            led4 = o.toInt();
            myString = "";
        }
    }
}
void sensorvalue1()
{
    int sdata = led1;
    Blynk.virtualWrite(V10, sdata);
}
void sensorvalue2()
{
    int sdata = led2;
    Blynk.virtualWrite(V11, sdata);
}
void sensorvalue3()
{
    int sdata = led3;
    Blynk.virtualWrite(V12, sdata);
}
void sensorvalue4()
{
    int sdata = led4;
    Blynk.virtualWrite(V13, sdata);
}
String getValue(String data, char separator, int index)
{
    int found = 0;
    int strIndex[] = {0, -1};
    int maxIndex = data.length() - 1;
    for (int i = 0; i <= maxIndex && found <= index; i++)
    {
        if (data.charAt(i) == separator || i == maxIndex)
        {
            found++;
            strIndex[0] = strIndex[1] + 1;
            strIndex[1] = (i == maxIndex) ? i + 1 : i;
        }
    }
    return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}