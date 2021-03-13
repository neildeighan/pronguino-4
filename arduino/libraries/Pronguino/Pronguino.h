/*
   Basic.h - Library Header file Pronguino.

   @author Neil Deighan
*/

// Safe guards against including more than once
#ifndef PRONGUINO_H
#define PRONGUINO_H

// Include the Basic Library
#include "Component.h"

class Controller {
  public:
    Controller();   // Need this ? check again default construtor for declaration ?
    Controller(int potPin, int switchPin, int ledPin);
    int readValue();
    int readButtonState();
    void writeLedState(int state);
  private:
    Potentiometer _pot;
    Switch _switch;
    LED _led;
};

#endif
