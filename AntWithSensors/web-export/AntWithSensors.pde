Gradient g1;
Gradient g2;
ArrayList<Gradient> gradienten;
ArrayList<Ant> ants;
float rotationAngle;
int counter = 0;
Paths paths;

void setup() {
  paths = new Paths();
  size(700, 700);
  rotationAngle = -PI/2;
  ants = new ArrayList<Ant>(); 
  ants.add(new Ant(new PVector(300, 480)));
  ants.add(new Ant(new PVector(300, 220)));
  ants.add(new Ant(new PVector(400, 300)));
  
  gradienten = new ArrayList<Gradient>();
  background(0);
  //noLoop();
}

void draw() {
  background(0);
  for(Gradient g: gradienten)
    g.drawGradient();
  paths.draw();
  for(Ant ant: ants)
    paths.addRectangle(ant.update());
  for(Ant ant: ants)
    ant.render();
  
}

void mousePressed() {
  if(gradienten.size() > 2)
    gradienten.remove(0);
  gradienten.add(new Gradient(mouseX, mouseY, (int)(120 + random( 50)), false)); 

}


class Ant{
  PVector location;
  PVector velocity;
  PVector dir;
  PVector home;
  float rotationAngle;  
  boolean goHome;
  ArrayList<PVector> sensorPositions;
  ArrayList<PVector> globalSensorPositions; 
  State state;

  Ant(){
   location = new PVector(width/2, height/2);
   setUp();
  }
  
  Ant(PVector _location){  
    location = _location;   
    setUp();
  }

private void setUp(){    
    velocity = new PVector(0.0,-0.5);
    dir = new PVector(1, 0);
    rotationAngle = 0;  
    
    sensorPositions = new ArrayList<PVector>();
    sensorPositions.add(new PVector(15,-7));
    sensorPositions.add(new PVector(15,7));
    globalSensorPositions = new ArrayList<PVector>();
    goHome = false;
    home = new PVector();
    state = State.SEARCHING;
  }
  
  void setHome(PVector newHome){
     home = newHome; 
     location.x = home.x;
     location.y = home.y;
  }
  
  void setLocation(PVector newLocation){
    location = newLocation;
  }
 
  void setSensorPositionsRelativeToMover(ArrayList<PVector> positions){
   sensorPositions = positions; 
  }
  
 public  ArrayList<PVector>  getLeftSensorPos(){
    return globalSensorPositions;
 }
 
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 4;
    translate(x,y);
    stroke(255);
    rotate(v.heading2D());
    float len = v.mag()*scayl;
    line(0,0,len,0);
    line(len,0,len-arrowsize,+arrowsize/2);
    line(len,0,len-arrowsize,-arrowsize/2);
    popMatrix();
  }
  
  public void setRotationAngle(float theta){
   rotationAngle = theta;
   dir.x = 1;
   dir.y = 0;
   rotate2D(dir, theta); 
  }
  
  Rectangle update(){
    //println(state);
    float lRedd = 0;
     float rRedd = 0;
     //int diff = 0;
     if(globalSensorPositions.size() > 0 && state != State.GOING_HOME){
       lRedd = red(get((int)globalSensorPositions.get(0).x,(int)globalSensorPositions.get(0).y));
       rRedd = red(get((int)globalSensorPositions.get(1).x,(int)globalSensorPositions.get(1).y));
       //diff = (int)(Math.abs(lRedd-rRedd));
       if(lRedd > rRedd){
         rotationAngle -= 0.05;
         if(lRedd > 235){
           state = State.GOING_HOME;
           //println("going home "+home.x+" "+home.y);
         }
       }else if (rRedd > lRedd){
         rotationAngle += 0.05;
         if(rRedd > 235){
           state = State.GOING_HOME;
           //println("going home "+home.x+" "+home.y);
         }
       }else{
        rotationAngle += random(-0.005, 0.005); //perlinnoise hier hin!
       }
       //println(lRedd+" : "+rRedd);
       setRotationAngle(rotationAngle);
     }
     else if(state == State.GOING_HOME){    
       dir.x = home.x;
       dir.y = home.y;
       //println("going home "+home.x+" "+home.y);
       dir.sub(location);    
       dir.setMag(map(dir.mag(), 0, 350, 0,20));  
       //println(dir.x+" "+dir.y);  
       //das hier ist sehr wichtig :-)
       rotationAngle = atan2(dir.y, dir.x);
       if(location.x < home.x +5 && location.y < home.y+5){
         //setRotationAngle(-PI);
         state = State.SEARCHING;
         //println("searching...");
       }
     }else{
      //FIXME mel state SEARCHING implementieren...
       dir.x = -home.x;
       dir.y = -home.y+random(-10, 10);
        //println(dir.y); 
     }
     edges();     
     velocity.add(dir);
     velocity.limit(1);   
     location.add(velocity);   
     drawVector(dir, location.x, location.y, 50);
     //drawVector(velocity, location.x, location.y, 50);
     return new Rectangle(location.x, location.y, rotationAngle);
   }  
  
private void calculateSensorPositionsToBaseCoordinateSystem(){
    
   globalSensorPositions.clear();    
    
   for(int i = 0; i < sensorPositions.size(); i++){
       float x = screenX(sensorPositions.get(i).x, sensorPositions.get(i).y);
       float y = screenY(sensorPositions.get(i).x, sensorPositions.get(i).y);
       globalSensorPositions.add(new PVector(x, y));     
     }
  } 

  void rotate2D(PVector v, float theta) {
    float xTemp = v.x;
    v.x = v.x*cos(theta) - v.y*sin(theta);
    v.y = xTemp*sin(theta) + v.y*cos(theta);
  }
   
 
  void edges(){
    if (location.x > width || location.x < 0){
      float theta;
       if(dir.y < 0){
          theta = PVector.angleBetween(dir, new PVector(0, -1));          
       }else{
         theta = PVector.angleBetween(dir, new PVector(0, 1));
       }
       setRotationAngle(theta);
    }
    else if(location.y > height || location.y < 0){
           float theta;
       if(dir.x < 0){
          theta = PVector.angleBetween(dir, new PVector(-1, 0));          
       }else{
         theta = PVector.angleBetween(dir, new PVector(1, 0));
       }
       //println(dir.x+" "+dir.y);
       setRotationAngle(theta);
    }
  }
  
  void render(){             
    pushMatrix();
    translate(location.x, location.y);
    rotate(rotationAngle);
    if(state == State.GOING_HOME)
      fill(0,125,0);
    else
      fill(125);
    stroke(155);
    calculateSensorPositionsToBaseCoordinateSystem();
    //triangle(-10, 10, -10, -10, 15, 0);
     ellipseMode(RADIUS);
    ellipse(-8,0, 8, 6);
    ellipse(3,0, 6, 4);
    //fill(255,0,0);
    for(PVector pos: sensorPositions)
     ellipse(pos.x, pos.y, 1,1);
    popMatrix();   
  }
}
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
public class Paths{
 ArrayList list;

public Paths(){
 list = new ArrayList();
}
public void addRectangle(Rectangle rect){
 list.add(rect);  
}

public int size(){
  return list.size();
}

public void draw(){
    for(int i = 0; i < list.size(); i++){ 
      Rectangle rect = (Rectangle)list.get(i);      
      rect.draw();      
      if(rect.getStrength() < 0){
        // remove from list
        list.remove(i);
      }
    }
  }
}
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
    strength = 70;
    angle = 0;    
  }
  
  Rectangle(float x, float y, float rot){
   pos = new PVector(x, y);
   angle = rot; 
   strength = 70; 
   with = 5; 
   heiht = 10;
  }
  
  Rectangle(PVector _pos, float rotationAngle){
   pos = _pos;
   angle = rotationAngle;
   strength = 70; 
   with = 5; 
   heiht = 10; 
  }
 
   Rectangle( final float x, final float y, int _w, int _h){
    pos = new PVector(x, y); 
    with = _w;
    heiht = _h;
    strength = 80;
    angle = 0;    
  }  
   
   public void draw(){
     noStroke();
     fill(220, 0, 0, strength);
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

