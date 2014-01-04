public class Ant {
  private PVector pos; 
  private PVector front;
  private PVector backLeft;
  private PVector backRight;
  private PVector frontLeft;
  private PVector frontRight;
  private float angle; 
  private boolean debug = false;
  
  public Ant(){
    pos = new PVector(0,0);
    front  = new PVector();
    backLeft = new PVector();
    backRight = new PVector(); 
    setUpPositions();
  }
  
  public Ant(PVector _pos){
    pos = _pos;
    front  = new PVector();
    backLeft = new PVector();
    backRight = new PVector();
    setUpPositions();
  }
  
  public void draw(){
   //FIXME mel push/pop gedöns & calculate global Pos's
    stroke(255); 
   fill(0);
    triangle(front.x, front.y, backLeft.x, backLeft.y, backRight.x, backRight.y); 
 }
 
 //FIXME mel das muss alles ander hier...
 public Rectangle move(){
   pos.y = pos.y -1;
   setUpPositions();  
   int w = int(backRight.x - backLeft.x);
   //FIXME mel return global Pos's
   final Rectangle rect = new Rectangle(backLeft.x, backLeft.y+2,w+1, 5);
   //println("\nreturning rect at: "+backLeft.x+", "+backLeft.y+" w: "+w);
   return  rect;
  }
  
  private void setUpPositions(){
         
   front.x = pos.x;
   front.y = pos.y-10;
   
   backLeft = new PVector(pos.x-8, pos.y+10);   
   backRight = new PVector(pos.x+8, pos.y+10);
   frontLeft = new PVector(pos.x-10, pos.y-10);
   frontRight = new PVector(pos.x+10, pos.y-10);
   if(debug){
     //print("front: ");
     //printPos(front);
     //print("backLeft: ");
    //printPos(backLeft);
   // print("backRight: ");
     //printPos(backRight);
     println("color: "+brightness(get((int)pos.x, (int)pos.y)));
   }
  }
  
  private void printPos(PVector pos){
    //println("X: "+pos.x+",Y: "+pos.y);
  }
  
}
