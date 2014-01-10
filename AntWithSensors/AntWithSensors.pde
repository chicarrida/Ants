Gradient g1;
Gradient g2;
//ArrayList<Gradient> gradienten;
Gradient gradient;
ArrayList<Ant> ants;
ArrayList<PVector> targets;
float rotationAngle;
Paths paths;
float counter;
PImage bg;

void setup() {
  paths = new Paths();
  size(700, 700);
  rotationAngle = -PI/2;
  ants = new ArrayList<Ant>(); 
  ants.add(new Ant(2*PI/1));
  ants.add(new Ant(2*PI/2));
  ants.add(new Ant(2*PI/3));
  ants.add(new Ant(2*PI/4));
  ants.add(new Ant(PI/2));
  ants.add(new Ant(PI/3));
  ants.add(new Ant(PI/4));
  targets = new ArrayList<PVector>();
  //gradienten = new ArrayList<Gradient>();
  background(0);
 // frameRate(5);
  counter = 255; 
}

void draw() {
  //float start = second();
  if(gradient == null && bg == null){
    background(0);
    bg = get();
  }
  else if(bg != null && gradient == null){
   //background(bg);
   background(0);
   tint(255, counter);
   counter -= 0.2;
   image(bg, 0, 0); 
   if(counter <= 45){
     counter = 255;
     targets.clear();
     bg = null;
//    println("targets cleared"); 
   }
   //println(counter);
  
  }
  else {
    //background(bg);
    background(0);
    tint(255, counter);
    counter = 255;
    image(bg, 0, 0);
    gradient.drawGradient();
    //println(counter);
    bg = get();
    gradient = null; 
  }
  
  fill(255, 0,0);
  noStroke();
  for(PVector target: targets){
    ellipse(target.x, target.y, 10, 10);
  }
  fill(120,120,220);
  ellipse(width/2, height/2, 10, 10);
  //for(Gradient g: gradienten)
    //g.drawGradient();
  paths.draw();
  for(Ant ant: ants){
    paths.addRectangle(ant.update());
    ant.render();
    ant.boundaries();
  }
  //println(second()-start);
}

void mousePressed() {
  //if(gradienten.size() > 5)
  //  gradienten.remove(0);
  //  gradienten.add(new Gradient(mouseX, mouseY, (int)(120 + random( 50)), true));
  gradient = new Gradient(mouseX, mouseY, (int)(120 + random( 50)), false);
  targets.add(new PVector(mouseX, mouseY));
  // for(Gradient g: gradienten)
  //  g.drawGradient();
}

void keyPressed(){
  if(key == 'r' || key == 'R'){
   gradient = null;
    bg = null; 
    targets.clear();
  }
}
 //FIXME mel add a reset function to reset bg to black
