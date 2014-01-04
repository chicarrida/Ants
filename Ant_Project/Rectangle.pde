public class Rectangle{
 private PVector pos;
 private int width;
 private int height;
 private float strength;
 private float angle;

  Rectangle( PVector _pos, int _w, int _h){
    pos = _pos; 
    width = _w;
    height = _h;
    strength = 80;    
  }
 
   Rectangle( final float x, final float y, int _w, int _h){
    pos = new PVector(x, y); 
    width = _w;
    height = _h;
    strength = 100;    
  }  
   
   public void draw(){
     noStroke();
     fill(255, 255, 255, strength);
     //println("draw rect at: "+(pos.x)+" "+(pos.y+4)+" w: "+ (width)+" h: "+height+ " strength"+ strength);
     rect(pos.x, pos.y, width, height);  
     strength -=0.2;
   }
  
  public float getStrength(){
    return strength;
  }
}
