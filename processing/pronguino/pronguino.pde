/**
 * Pronguino - Servuino
 *
 * Serving with Arduino
 *
 * https://neildeighan.com/pronguino-4/
 *
 * @author  Neil Deighan
 *
 */

// Import the serial library
import processing.serial.*;

// Declare Serial Port
Serial usbPort;

// Declare Game Options
Options options;

// Declare Debug Options
Debug debug;

// Declare Game Objects
Surface surface;
Net net;
Ball ball;
Scoreboard[] scoreboards;
Player[] players;
Player player;

// Declare State 
int state;

// Declare Player to Serve
Player playerToServe;    

/**
 * Setup environment, load options, create game objects, initialise serial communications
 */
void setup() 
{
  // Set Window size in pixels, these are refered to throughout code as "width" and "height" respectively,
  // and all game objects have been coded to be displayed relative to these, so you can have a really short game at 100 x 100,
  // or a really long game at say 1280 x 640, size() can also be replace with fullScreen().
  //
  // Note: Now that a playing surface has been added game objects are drawn relative to this, although the 
  //       surface as been drawn relative to "width" and "height".  
  size(800, 600);

  // Game being setup
  state = Constants.STATE_SETUP;

  // "Load" Game Options
  options = new Options();

  // "Load" Debug options
  debug = new Debug();

  // Set Frame Per Second (FPS)
  frameRate(options.framesPerSecond);

  // Create Surface
  surface = new Surface(75, 100); 

  // Create Net
  net = new Net();

  // Create Ball  
  ball = new Ball();

  // Create Scoreboards 
  float fontSize = options.scoreboardFontSize;
  PFont font = createFont(options.scoreboardFont, fontSize);

  scoreboards = new Scoreboard[Constants.PLAYER_COUNT];
  scoreboards[Constants.PLAYER_ONE] = new Scoreboard(width/2-(fontSize*2), surface.y - fontSize*1.5, font); 
  scoreboards[Constants.PLAYER_TWO] = new Scoreboard(width/2+(fontSize*0.25), surface.y - fontSize*1.5, font);

  // Create Players, each player will create its own paddle and controller
  players = new Player[Constants.PLAYER_COUNT];
  for (int index=0; index < Constants.PLAYER_COUNT; index++) {
    players[index] = new Player(index);
  }

  // Get Serial Port name .. change in Options once identified 
  // println(Serial.list());

  // Connect to serial port, just show error message for now,
  // the game will just continue to use keyboard controls 
  try {
    usbPort = new Serial(this, options.serialPortName, options.serialBaudRate);
  } 
  catch (Exception e) {
    println(e.getMessage());
  }

  // Set each players starting position for paddles 
  for (Player player : players) {
    player.paddle.positionAtStart();
  }

  // Player to serve
  playerToServe = players[Constants.PLAYER_ONE];

  // Set starting position for ball
  ball.positionAtPlayer(playerToServe);

  if(!playerToServe.controller.connected) {
    state = Constants.STATE_SERVE;
  }
    
  // Only set background the once, when debugging 
  if (options.debug) {   
    background(options.backgroundColour);
  }
}

/**
 * Called everytime a key is pressed 
 */
void keyPressed() {

  // Check if any players control keys pressed
  for (Player player : players) {
    player.checkKeyPressed(key);
  }

  // Check if space key hit
  if (key == Constants.KEY_SPACE) {
    performAction();
  }
}

/**
 * Called everytime a key is released
 */
void keyReleased() {

  // Check if any players control keys released
  for (Player player : players) {
    player.checkKeyReleased(key);
  }
}

/**
 * Called when controllers have initialized
 */
void controllersReady() {

  // Set Serve Indicator to on for player
  playerToServe.controller.indicator.setState(Constants.INDICATOR_STATE_ON);
  
  // Set game state waiting for serve
  state = Constants.STATE_SERVE;
}

/**
 * Called everytime button is pressed
 *
 * @param  playerIndex 
 */
void buttonPressed(int playerIndex) {
  // playerIndex not used yet 
  performAction();
}

/**
 * Called everytime button is released
 *
 * @param  playerIndex 
 */
void buttonReleased(int playerIndex) {
  // Nothing to do yet
}

 
/**
 * Called when indicator state changes
 */
void indicatorChanged(int playerIndex, int indicatorStatus) {
  // Write data to Arduino, only if controller connected
  if(players[playerIndex].controller.connected) {
    usbPort.write(Functions.getIndicatorData(playerIndex, indicatorStatus));
    // Small delay to allow processing
    delay(10);
  }
}

/**
 * Called when no data available
 */
void noDataAvailable() {
  // Stop moving paddles as no data ...
  for (Player player : players) {
    player.paddle.stopMoving();
  }
}

/**
 * Called everytime data is received from the serial port
 */
void serialEvent(Serial usbPort) {

  // Is there any data available ?
  while (usbPort.available() > 0) {

    // Get the data from port
    byte data = (byte)usbPort.read();

    // Split data into two nibbles .. one for each players controller    
    int highNibble = Functions.getHighNibble(data);
    int lowNibble = Functions.getLowNibble(data);

    // Set the value of each controller (first 3 bits of nibble ... 0-7)
    players[Constants.PLAYER_ONE].controller.setValue(highNibble & Constants.DATA_BITS_VALUE);    
    players[Constants.PLAYER_TWO].controller.setValue(lowNibble & Constants.DATA_BITS_VALUE);

    // Set the state of each controllers button (4th or most significant bit of each nibble ... 0-1)
    players[Constants.PLAYER_ONE].controller.button.setState((highNibble & Constants.DATA_BITS_STATE) >> 3); 
    players[Constants.PLAYER_TWO].controller.button.setState((lowNibble & Constants.DATA_BITS_STATE) >> 3);

    // Small delay before getting any further data
    delay(100);
  } 
  noDataAvailable();
}

/**
 * The code within this function runs continuously in a loop
 */
void draw() 
{

  // Set background in draw() when not debugging, as it needs to be drawn every frame. 
  if (!options.debug) {   
    background(options.backgroundColour);
  }

  // Move the ball
  switch(state) {
  case Constants.STATE_STARTED:
    ball.move();
    break;
  case Constants.STATE_SERVE:
    // Move the ball with the players paddle
    ball.positionAtPlayer(playerToServe);
    break;
  }

  // Move player paddles
  for (Player player : players) {
    player.paddle.move();
  }

  // Check if the ball hits the surface boundary
  if (ball.hitsBoundary()) {
    try {
      // This will only cause error if we provided an invalid parameter, try it
      ball.bounce(Constants.AXIS_VERTICAL);
    } 
    catch (Exception e) {
      // Just show error message for now
      // the game will continue, but you will see some strange movements
      println(e.getMessage());
    }
  }   

  // Check if player paddle hits the surface boundary
  for (Player player : players) {
    if (player.paddle.hitsBoundary()) {
      // Reposition
      player.paddle.positionAtBoundary();
      // Stop
      player.paddle.stopMoving();
    }
  }

  // Check if player paddle hits ball
  for (Player player : players) {
    if (player.paddle.hits(ball)) {

      // Debug
      if (options.debug && debug.playerHitsBall) {
        ball.display(true);
        saveFrame("debug/Player("+player.index+")-Paddle"+player.paddle.location+"-Hits-Ball"+ball.location);
      }

      // Reposition
      ball.reposition(player);

      // Debug
      if (options.debug && debug.ballReposition) {
        saveFrame("debug/Ball-Position"+ ball.location+"-At-Player("+player.index+")-Paddle"+player.paddle.location);
      }

      // Bounce
      try {
        // This will only cause error if we provided an invalid parameter, try it.
        ball.bounce(Constants.AXIS_HORIZONTAL);
      } 
      catch (Exception e) {
        // Just show error message for now, the game will continue, but you will see some strange movements
        println(e.getMessage());
      }
    }
  }

  // Check if player paddle misses ball
  for (Player player : players) {
    if (player.paddle.misses(ball)) {
      // Add point to other players score
      players[player.index^1].score++;

      // Move to ball to players paddle
      ball.positionAtPlayer(player);

      // Set the current player to serve
      playerToServe = player;

      // Set Serve Indicator to on for player
      player.controller.indicator.setState(Constants.INDICATOR_STATE_ON);

      // Waiting to serve
      state = Constants.STATE_SERVE;
    }
  }

  // Update scoreboards
  for ( Player player : players) {
    scoreboards[player.index].update(player.score);
  }

  // Check for winner
  for (Player player : players) {
    if (player.score == Constants.SCORE_MAX) {    

      // Game Ended
      state = Constants.STATE_ENDED;
      noLoop();
    }
  }

  // Display the game objects
  surface.display();
  net.display();
  ball.display(false);
  for (Player player : players) {
    scoreboards[player.index].display();
    player.paddle.display();
  }

  // Saves an image of screen every frame, which can be used to make a movie
  // saveFrame("movie/frame-######.tif");
  // WARNING: Remove or comment if not in use, can fill up disk space if forgotton about
}


/**
 * Perform Game Action
 */
void performAction() {

  // Determine what action to take depending on state
  switch(state) {
  case Constants.STATE_STARTED:
    pauseGame();
    break;
  case Constants.STATE_PAUSED:
    resumeGame();
    break;
  case Constants.STATE_ENDED:
    newGame();
    break;
  case Constants.STATE_SERVE:    
    serve();
    break;
  }
}

/**
 * Serve
 */
void serve() {

  // Set direction of ball from start position, depending on who missed
  ball.directionAtStart(playerToServe);     

  // Set indicator to OFF
  playerToServe.controller.indicator.setState(Constants.INDICATOR_STATE_OFF);
  
  state = Constants.STATE_STARTED;
  loop();
}

/**
 * Pause Game
 */
void pauseGame() {
  state = Constants.STATE_PAUSED;
  noLoop();
}

/**
 * Restart Game
 */
void resumeGame() {
  // Game Restarted
  state = Constants.STATE_STARTED;
  loop();
}

/**
 * New Game
 */
void newGame() {

  // Reset Scores & Player Positions
  for (Player player : players) {
    player.score = 0;
    if (player.controller.connected) {
      player.paddle.positionByController();
    } else {
      player.paddle.positionAtStart();
    }
  }

  // New Game Started, Wait for Service
  state = Constants.STATE_SERVE;
  loop();
}
