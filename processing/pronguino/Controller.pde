/**
 * Controller
 *
 * Encapsulates the players "controller", when Arduino connected
 *
 * @author  Neil Deighan
 */
class Controller {

  Player parent; 
  int currentValue;
  int previousValue;
  boolean connected;
  Button button;
  Indicator indicator;
  
  /**
   * Class constructor
   *
   * @param  player  parent of this controller
   */
  Controller(Player player) {
    
    // Sets the parent of controller
    this.parent = player;
    
    // Create Button
    this.button = new Button(this);
  
    // Create Indicator
    this.indicator = new Indicator(this);
    
    // Not Connected Yet
    this.connected = false;
  }

  /**
   * Sets current value of controller, and "raise" initialize / changed event accordingly
   *
   * @param  value  new value from controller
   */
  void setValue(int value) {

    // Set value
    this.currentValue = value;

    // Set connected flag
    this.connected = true;
    // If value has changed ...
    if(this.currentValue != this.previousValue) {

      // ... raise "Event" ...
      if(state == Constants.STATE_SETUP) {
        this.parent.controllerInitialize();
      }
      else {
        this.parent.controllerChanged();
      }
      
      // .. and set the previous value, so we can determine changes next time round ...
      this.previousValue = this.currentValue;
    }
  }

  /**
   * Calculates the difference between the current and previous values
   *
   * @return  value difference
   */
  int valueDifference() {
    return (this.currentValue - this.previousValue);
  }
  
}
