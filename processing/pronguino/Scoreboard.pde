/**
 * Scoreboard
 *
 * Encapsulates the scoreboard
 *
 * @author  Neil Deighan
 */
class Scoreboard {
  int score;
  float x;
  float y;
  float w;
  float h;
  PFont font;

  /**
   * Class constructor
   *
   * @param  x      x co-ord of scoreboard
   * @param  y      y co-ord of scoreboard
   * @param  font   font family
   */
  Scoreboard(float x, float y, PFont font) {
    this.score = 0;
    this.font = font;
    this.x = x;
    this.y = y;
    this.w = this.font.getSize() * 1.75;
    this.h = this.font.getSize() * 1.25;   
  }

  /**
   * Update the scoreboard
   *
   * @param  score
   */
  void update(int score) {
    this.score = score;
  }

  /**
   * Draw the scoreboard
   */
  void display() {

    // Board
    stroke(#202020);
    strokeWeight(1);
    fill(#0f0f0f);
    rect(x, y, w, h, 5);
    
    // Score
    fill(#ffffff);  
    textFont(font);
    textAlign(RIGHT);
    text(this.score, this.x + font.getSize()*1.50, this.y + this.h*0.80);
  }
}
