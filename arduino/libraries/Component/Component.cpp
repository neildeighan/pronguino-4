/*
  Basic.cpp - Implementation of component library.

  @author Neil Deighan
*/

// Include Component Library
#include "Component.h"

// Include the Arduino library
#include <Arduino.h>

/**
   Default Class Constructor
*/
Potentiometer::Potentiometer() {}

/**
  Class Constructor

  @param  pin analog pin number connected to potentiometer
*/
Potentiometer::Potentiometer(int wiperPin)
{
  _wiperPin = wiperPin;
};

/**
   Reads wiper value from analog pin connected to potentiometer

   @return  wiper value 
*/
int Potentiometer::readWiperValue()
{
  // Reads wiper value from pin, which would be a value mapped from 0 to 5V (0 to 1023)
  int wiperValue = analogRead(_wiperPin); 

  // Small delay to allow the Analog-to-Digital Converter (ADC) to process
  delay(1);

  return wiperValue;
};


/**
   Default Class Constructor
*/
Switch::Switch() {}

/**
  Class Constructor

  @param  pin digital pin number connected to switch
*/
Switch::Switch(int statePin)
{
  // Set Pin
  _statePin = statePin;

  // Set Pin Mode to input
  pinMode(_statePin, INPUT);
};

/**
   Reads state from digital pin connected to switch

   @return  state (HIGH / LOW)
*/
int Switch::readState()
{
  // Read and return state from pin
  return digitalRead(_statePin);

  // Might need a small delay, as it sends again after change ???
};



/**
   Default Class Constructor
*/
LED::LED() {}

/**
  Class Constructor

  @param  pin digital pin number connected to anode
*/
LED::LED(int anodePin)
{
  // Set Pin
  _anodePin = anodePin;

  // Set Pin Mode to output
  pinMode(_anodePin, OUTPUT);
};

/**
   Writes state to pin 

   @param state HIGH/LOW  (On/Off)
*/
void LED::writeState(int state)
{
  // Write state to pin
  digitalWrite(_anodePin, state);

};
