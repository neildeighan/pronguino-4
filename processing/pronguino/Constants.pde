/**
 * Constants
 *
 * Logically named constants to remove the need to use numbers in rest of code, make more understandable, and less error prone 
 *
 * @author  Neil Deighan
 */
public static class Constants {

  static final int PLAYER_ONE = 0;               // Index for player 1
  static final int PLAYER_TWO = 1;               // Index for player 2
  static final int PLAYER_COUNT = 2;             // Number of players    

  static final int AXIS_HORIZONTAL = 1;          // Axes on which paddle or ball is moving/bouncing on
  static final int AXIS_VERTICAL = 2;

  static final int DIRECTION_LEFT = -1;          // Multiplier used on the x co-ord of ball to go left
  static final int DIRECTION_RIGHT = 1;          // Multiplier used on the x co-ord of ball to go right
  static final int DIRECTION_UP = -1;            // Multiplier used on the y co-ord of paddle to go up
  static final int DIRECTION_DOWN = 1;           // Multiplier used on the y co-ord of paddle to go down
  static final int DIRECTION_OPPOSITE = -1;      // Multiplier used on the x/y co-ord of ball/paddle to go in opposite direction
  static final int DIRECTION_NONE = 0;           // Multiplier used on the x/y co-ord of ball/paddle stop

  static final int CONTROLLER_VALUE_MIN = 1;     // Minimum value (nibble) being received from controller input i.e. 0x0000 or 0000
  static final int CONTROLLER_VALUE_MAX = 7;     // Maximum value (nibble) being received from controller input i.e. 0x0007 or 0111
  
  static final int SCORE_MAX = 10;               // Winning Score
  
  static final char KEY_SPACE = ' ';             // Space Character
  
  static final int STATE_SETUP = 0;              // Game setting up
  static final int STATE_STARTED = 1;            // Game started state
  static final int STATE_ENDED = 2;              // Game ended state 
  static final int STATE_PAUSED = 3;             // Game paused state
  static final int STATE_SERVE = 4;              // Game waiting to serve state
  
  static final int DATA_BITS_NIBBLE = 0x0F;      // Bit mask used to extract nibble from data (00001111)
  static final int DATA_BITS_VALUE = 0x07;       // Bit mask used to extract value of controller from nibble (00000111)
  static final int DATA_BITS_STATE = 0x08;       // Bit mask used to extract state of button from nibble (00001000)
  
  static final int BUTTON_STATE_LOW = 0;         // Button unpressed
  static final int BUTTON_STATE_HIGH = 1;        // Button pressed
  
  static final int INDICATOR_STATE_OFF = 0;      // Serve Indicator Off  
  static final int INDICATOR_STATE_ON = 1;       // Serve Indicator On
  
  
}
