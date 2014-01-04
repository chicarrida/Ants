public class Gradient{

  private int x;
  private int y;
  private boolean umriss;
  private float radius;
  private int timer;  
  public Gradient (int _x, int _y, int _radius, boolean _umriss){
    x = _x;
    y =_y;
    radius = _radius;
    umriss = _umriss;
    
  }

  public Gradient (){
    x = 10;
    y =10;
    radius = 100;
    umriss = false;
  }
 
  
  public void drawGradient() {  
   ellipseMode(RADIUS);
   float h = 0;
    if(umriss){
      fill(0);
      stroke(120);
      ellipse(x,y,radius,radius);
    }
   noStroke();   
   for (int r = (int)radius; r > 0; --r) {
    float tmpR = map(r,0,radius, 0,6);
    h = 2/(tmpR*tmpR+0.5);
    h= map(h, 0, 2, 0, 255);    
    color c = color(h,0,0);   
    fill(c);       
    ellipse(x, y, r, r);     
  }
}
}
