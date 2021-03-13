/**
 * Player
 *
 * Encapsulates the player
 *
 * @author  Neil Deighan
 */
class Player {

  int index;
  int score;
  char upKey;
  char downKey;

  Controller controller;
  Paddle paddle;

  /**
   * Class Constructor
   *
   * @param  index  array index of the player being created
   */
  Player(int index) {
    
    // Sets Players Index
    this.index = index;
    
    // Sets Score
    this.score = 0;

    // Sets the control keys for the player
    this.upKey = options.keys[index].up;
    this.downKey = options.keys[index].down;

    // Create Controller
    this.controller = new Controller(this);

    // Create Paddle
    this.paddle = new Paddle(this);
  }
  
  /**
   * Called everytime controller value changes
   */
  void controllerChanged() {

    // If the difference is negative, we want to move up .. down if positive ..
    this.paddle.setDirection( this.controller.valueDifference() < 0 ? Constants.DIRECTION_UP : Constants.DIRECTION_DOWN);
     
    // Set factor to multiply speed
    this.paddle.setSpeedFactor(abs(this.controller.valueDifference())*2);
     
    // Note: as the controller could change quickly from a low value to a high value, say 2 to 5,
    // we have to add the difference into the factor, and also multply by 2, as range decreased 
    // to 1-7 from 0-15 
  }

   /**
    * Called when controller initializes
    */
   void controllerInitialize() {
    // Set the paddle position based on controller values
    this.paddle.positionByController();

    // Raise "Event" ... to say controllers are ready
    controllersReady();
  }
  
  /**
   * Checks which key has been pressed to determine direction of players paddle
   *
   * @param  pressedKey  
   */
  void checkKeyPressed(char pressedKey) {
    
    if (pressedKey == this.downKey) {
      this.paddle.setDirection(Constants.DIRECTION_DOWN);
    } else {
      if (pressedKey == this.upKey) {
        this.paddle.setDirection(Constants.DIRECTION_UP);
      }
    }
    
    // Set speed factor for keyboard
    this.paddle.setSpeedFactor(1.0);

  }

  /**
   * Checks which key has been released stop movement of players paddle
   *
   * @param  releasedKey  
   */
  void checkKeyReleased(char releasedKey) {
    if (releasedKey == this.downKey || releasedKey == this.upKey) {
      this.paddle.setDirection(Constants.DIRECTION_NONE);
    }
  }

}
