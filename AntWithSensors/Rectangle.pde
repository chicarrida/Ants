public class Rectangle{
 private PVector pos;
 private int with;
 private int heiht;
 private float strength;
 private float angle;

  Rectangle( PVector _pos, int _w, int _h){
    pos = _pos; 
    with = _w;
    heiht = _h;
    strength = 50;
    angle = 0;    
  }
  
  Rectangle(float x, float y, float rot){
   pos = new PVector(x, y);
   angle = rot; 
   strength = 50; 
   with = 5; 
   heiht = 10;
  }
  
  Rectangle(PVector _pos, float rotationAngle){
   pos = _pos;
   angle = rotationAngle;
   strength = 50; 
   with = 5; 
   heiht = 10; 
  }
 
   Rectangle( final float x, final float y, int _w, int _h){
    pos = new PVector(x, y); 
    with = _w;
    heiht = _h;
    strength = 0;
    angle = 0;    
  }  
   
   public void draw(){
     noStroke();
     fill(0, 220, 0, strength);
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
  
  public float getStrength(){
    return strength;
  }
}
