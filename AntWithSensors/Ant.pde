class Ant{
  PVector location;
  PVector velocity;
  PVector dir;
  PVector home;
  float rotationAngle;  
  ArrayList<PVector> sensorPositions;
  ArrayList<PVector> globalSensorPositions; 
  State state;
  color c;
  //distance to boundaries of window
  int d = 20;
  
  Ant(){
   location = new PVector(width/2, height/2);
   setUp();
  }
  
  Ant(float angle){
   location = new PVector(width/2, height/2);
   setUp();
   setRotationAngle(angle);
  }
  
  Ant(PVector _location){  
    location = _location;   
    setUp();
  }

private void setUp(){  
    c = color(125,125,125);  
    velocity = new PVector(0.0,-0.5);
    dir = new PVector(1, 0);
    rotationAngle = 0;  
    
    sensorPositions = new ArrayList<PVector>();
    sensorPositions.add(new PVector(15,-7));
    sensorPositions.add(new PVector(15,7));
    globalSensorPositions = new ArrayList<PVector>();
    home = new PVector(width/2,height/2);
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
    stroke(155);
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
    float lRedd = 0;
    float rRedd = 0;
     
    float lGreen = 0;
    float rGreen = 0;
    
    if(globalSensorPositions.size() > 0 && state != State.GOING_HOME){
      lRedd = red(get((int)globalSensorPositions.get(0).x,(int)globalSensorPositions.get(0).y));
      rRedd = red(get((int)globalSensorPositions.get(1).x,(int)globalSensorPositions.get(1).y));
      lGreen = green(get((int)globalSensorPositions.get(0).x,(int)globalSensorPositions.get(0).y));
      rGreen = green(get((int)globalSensorPositions.get(1).x,(int)globalSensorPositions.get(1).y));
      if(lRedd > rRedd){
        rotationAngle -= random(0.05, 0.08);
        if(lRedd > 235){         
          c = color(0,255,0);
          state = State.GOING_HOME;  
         println("going home");     
        }
      }else if (rRedd > lRedd){
        rotationAngle += random(0.05, 0.08);
        if(rRedd > 235){
           c = color(0,255,0);
            state = State.GOING_HOME;
           println("going home");     
        }
      }else if(lGreen > rGreen){
        rotationAngle -= 0.05;    
      }else if (rGreen > lGreen){
        rotationAngle += 0.05;
      }
      else{
       rotationAngle += random(-0.05, 0.05); //perlinnoise hier hin!
      }       
      setRotationAngle(rotationAngle);
    }
    else if(state == State.GOING_HOME){    
      dir.x = home.x; //<>//
      dir.y = home.y;       
      dir.sub(location);                  
      //dir.limit(1); 
      rotationAngle = atan2(dir.y, dir.x);
      setRotationAngle(rotationAngle);
      if(location.x < home.x +5 && location.y < home.y+5 && location.x > home.x -5 && location.y > home.y-5){
        setRotationAngle(-rotationAngle);
        state = State.SEARCHING;
        c = color(127, 127, 127);
      }
    }
    velocity.add(dir);
    velocity.limit(1);
    location.add(velocity);   
    //drawVector(dir, location.x, location.y, 50);
    drawVector(velocity, location.x, location.y, 50);
   // println(velocity.x+" "+velocity.y+ " "+velocity.mag());
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

 void boundaries() {

    PVector desired = null;

    if (location.x < d) {
      desired = new PVector(3, velocity.y);
    } 
    else if (location.x > width -d) {
      desired = new PVector(-3, velocity.y);
    } 

    if (location.y < d) {
      desired = new PVector(velocity.x, 3);
    } 
    else if (location.y > height-d) {
      desired = new PVector(velocity.x, -3);
    } 

    if (desired != null) {   
      desired.normalize();
      desired.mult(3);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(0.2);
      setRotationAngle(desired.heading());    
    }
    
  }   
  
  void render(){             
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());    
    fill(c);    
    stroke(55);
    calculateSensorPositionsToBaseCoordinateSystem();    
    ellipseMode(RADIUS);
    ellipse(-8,0, 8, 6);
    ellipse(3,0, 6, 4);
    for(PVector pos: sensorPositions)
     ellipse(pos.x, pos.y, 1,1);
    popMatrix();   
  }
}
