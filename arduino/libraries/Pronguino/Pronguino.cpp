/*
  Pronguino.cpp - Implementation of Pronguino.h

  @author Neil Deighan
*/

#include "Pronguino.h"

// Include the Arduino library
#include <Arduino.h>

/**
   Default Class Constructor
*/
Controller::Controller() {}

/**
  Class Constructor

  @param  pin analog pin number connected to potentiometer
*/
Controller::Controller(int potPin, int switchPin, int ledPin)
{
  _pot = Potentiometer(potPin);
  _switch = Switch(switchPin);
  _led = LED(ledPin);
};

/**
   Reads value from analog pin connected to potentiometer

   @return  value
*/
int Controller::readValue()
{
  
  // Reads wiper value from pot, which would be a value mapped from 0 to 5V (0 to 1023)
  int wiperValue = _pot.readWiperValue();
  
  // Map the pot value to number between 1 and 7
  int  value = map(wiperValue, 0, 1022, 1, 7);

  // Note: When pot was all the way high, value varied between 1022/1023, 
  // and causing value to be calculated to 6/7 without moving, so reduced 
  // high end mapping value to 1022, seemed to hold at 7 then!
  
  return value;
};

/**
   Reads state of button

   @return  state (HIGH / LOW)
*/
int Controller::readButtonState()
{
  return _switch.readState();
};

/**
   Writes state to led pin

   @param  state (HIGH / LOW)
*/
void Controller::writeLedState(int state)
{
  _led.writeState(state);
};
