public class Rectangle {
  private PVector pos;
  private int with;
  private int heiht;
  private float strength;

  private color c;
  private float angle;


  Rectangle(float x, float y, float rot, State status) {
    pos = new PVector(x, y);
    angle = rot;
    if (status == State.SEARCHING) { 
      strength = 10;      
    } else {       
      strength = 40;
    } c = color(0, 220, 0);
    with = 5; 
    heiht = 10;
  }

  public void draw() {
    noStroke();     
    fill(red(c), green(c), blue(c), strength);
    //println("draw rect at: "+(pos.x)+" "+(pos.y+4)+" w: "+ (width)+" h: "+height+ " strengt h"+ strength+" angel "+angle);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    rectMode(CENTER);
    rect(0, 0, with, heiht);  
    strength -=0.1;
    popMatrix();
    //fill(0,255,0, strength);
    //ellipse(pos.x, pos.y, 2, 2);
  }

  public float getStrength() {
    return strength;
  }
}
