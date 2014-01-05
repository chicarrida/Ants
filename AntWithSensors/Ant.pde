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
    //sensorPositions.add(new PVector(-7, 15));
    //sensorPositions.add(new PVector(7,15));
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
   //println("winkel "+rotationAngle);
   dir.x = 1;
   dir.y = 0;
   rotate2D(dir, theta); 
  }
  
  Rectangle update(){
   // println(state);
    float lRedd = 0;
     float rRedd = 0;
     
     float lGreen = 0;
     float rGreen = 0;
     //int diff = 0;
     if(globalSensorPositions.size() > 0 && state != State.GOING_HOME){
       lRedd = red(get((int)globalSensorPositions.get(0).x,(int)globalSensorPositions.get(0).y));
       rRedd = red(get((int)globalSensorPositions.get(1).x,(int)globalSensorPositions.get(1).y));
       
        lGreen = green(get((int)globalSensorPositions.get(0).x,(int)globalSensorPositions.get(0).y));
       rGreen = green(get((int)globalSensorPositions.get(1).x,(int)globalSensorPositions.get(1).y));
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
         }else if(lGreen > rGreen){
         rotationAngle -= 0.05;       
       }else if (rGreen > lGreen){
         rotationAngle += 0.05;
       }
        }else{
 
        rotationAngle += random(-0.05, 0.05); //perlinnoise hier hin!
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
       //setRotationAngle(rotationAngle);
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
     velocity.add(dir);
     velocity.limit(1);   
     location.add(velocity);   
     drawVector(dir, location.x, location.y, 50);
     drawVector(velocity, location.x, location.y, 50);
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
   
void checkEdges() {

    if (location.x > width) {
      location.x = width-5;
      velocity.x *= -1;
      dir.x *= -1;
    } else if (location.x < 0) {
      location.x = 0+5;
      velocity.x *= -1;
      dir.x *=-1;
    }
      if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }

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
    //println("drawAngle "+rotationAngle);
    println();
    rotate(rotationAngle);
    if(state == State.GOING_HOME)
      fill(0,125,0);
    else
      fill(125);
    stroke(155);
    calculateSensorPositionsToBaseCoordinateSystem();
    //triangle(-10, 10, -10, -10, 15, 0);
     ellipseMode(RADIUS);
  //  ellipse(0,0, 6, 8);
   
   // ellipse(0,10, 4, 6);
      ellipse(-8,0, 8, 6);
    ellipse(3,0, 6, 4);
    //fill(255,0,0);
    for(PVector pos: sensorPositions)
     ellipse(pos.x, pos.y, 1,1);
    popMatrix();   
  }
}
