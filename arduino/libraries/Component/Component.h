/*
   Basic.h - Library Header file for components.

   @author Neil Deighan
*/

// Safe guards against including more than once
#ifndef COMPONENT_H
#define COMPONENT_H

// Declaration of Potentiometer class
class Potentiometer
{
  public:
    Potentiometer();
    Potentiometer(int wiperPin);
    int readWiperValue();
  private:
    int _wiperPin;     
};

// Declaration of Switch class
class Switch
{
  public:
    Switch();
    Switch(int statePin);
    int readState();
  private:
    int _statePin;
};

// Declaration of LED class
class LED
{
  public:
    LED();
    LED(int anodePin);
    void writeState(int state);
  private:
    int _anodePin;  
};

#endif
