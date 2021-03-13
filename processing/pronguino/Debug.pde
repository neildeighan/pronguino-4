/**
 * Debug
 *
 * Allows different areas to be toggled for debugging.
 * 
 * @author  Neil Deighan
 */
class Debug {

  boolean playerHitsBall;              // Debug option for when the paddle hits the ball
  boolean ballReposition;              // Debug option for when the ball is repositioned
  boolean paddleHitsBoundary;          // Debug option for when the paddle hits boundary
  boolean ballHitsBoundary;            // Debug option for when the ball hits boundary
  
  /**
   * Class Constructor
   */
  Debug() {
    playerHitsBall = true;
    ballReposition = false;
    paddleHitsBoundary = false;   
    ballHitsBoundary = false;
  }
}
