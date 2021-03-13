/**
 * Options
 *
 * This is where all the configurable options of the game would go, have defaulted the properties here, 
 * but would normally have a method of saving and loading these options
 *
 * @author  Neil Deighan
 */
class Options {

  float framesPerSecond;    // Number of frames to be displayed every second
  float netWidth;           // Width of net element in pixels 
  float netHeight;          // Height of net element in pixels
  float netGap;             // Size of gap between net elements
  float ballSpeed;          // Number of pixels to add when moving ball
  float ballRadius;         // Radius of ball in pixels 
  float paddleSpeed;        // Number of pixels to add when moving paddle
  float paddleWidth;        // Width of paddle in pixels
  float paddleHeight;       // Height of paddle in pixels
  color backgroundColour;   // RGB value of background colour, hex format  
  String scoreboardFont;    // Name of font used for scoreboard, file must be in data folder
  float scoreboardFontSize; // Size of font, also used for positioning of scoreboard
  String serialPortName;    // Name of serial port when Arduino is plugged into USB port, use println(Serial.list()); in setup() to find which one to use
  int serialBaudRate;       // Baud rate of serial communications between Arduino and serial port, must be set same on both 
  Keys[] keys;              // Keys for paddle control (up, down) for players
  float surfaceLineWidth;   // Width of borders / lines on playing surface in pixels
  color netColour;          // Net Colour
  color[] paddleColours;    // Paddle Colours
  color ballColour;         // Ball Colour
  boolean debug;            // Toggle for debug mode on/off
  
  /**
   * Class Constructor
   */
  Options() {
    framesPerSecond = 60.0;            
    netWidth = 2.0;                     
    netHeight = 6.0;                  
    netGap = 5.0;                     
    ballSpeed = 5.0;                   
    ballRadius = 5.0;                    
    paddleSpeed = 6.0;                 
    paddleWidth = 10.0;                
    paddleHeight = 50.0;               
    backgroundColour = color(#000000);                        // Black          
    scoreboardFont = "Orbitron-Medium.ttf";     
    scoreboardFontSize = 48.0;         
    serialPortName = "/dev/ttyACM0";  
    serialBaudRate = 9600;
    keys = new Keys[Constants.PLAYER_COUNT];
    keys[Constants.PLAYER_ONE] = new Keys('q', 'a'); 
    keys[Constants.PLAYER_TWO] = new Keys('p', 'l');
    surfaceLineWidth = 3;
    netColour = color(#707070);                               // Grey
    paddleColours = new color[Constants.PLAYER_COUNT];   
    paddleColours[Constants.PLAYER_ONE] = color(#ee181e);     // Red
    paddleColours[Constants.PLAYER_TWO] = color(#35b748);     // Green
    ballColour = color(#f2d223);                              // Yellow
    debug = false;
  }
}
