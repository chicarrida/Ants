Gradient g1;
Gradient g2;
ArrayList<Gradient> gradienten;
Gradient gradient;
ArrayList<Ant> ants;
float rotationAngle;
int counter = 0;
Paths paths;
PImage bg;
void setup() {
  paths = new Paths();
  size(700, 700);
  rotationAngle = -PI/2;
  ants = new ArrayList<Ant>(); 
  ants.add(new Ant(random(0, 2*PI)));
  ants.add(new Ant(random(0, 2*PI)));
  ants.add(new Ant(random(0, 2*PI)));
  ants.add(new Ant(random(0, 2*PI)));
  ants.add(new Ant(random(0, 2*PI)));
  gradienten = new ArrayList<Gradient>();
  background(0); 
}

void draw() {
  //float start = second();
  if(gradient == null && bg == null){
    background(0);
    bg = get();
  }
  else if(bg != null && gradient == null)
   background(bg); 
  else {
    background(bg);
    gradient.drawGradient();
    bg = get();
    gradient = null; 
  }
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
  // for(Gradient g: gradienten)
  //  g.drawGradient();
}
 //FIXME mel add a reset function to reset bg to black


