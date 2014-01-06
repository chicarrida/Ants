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
  ants.add(new Ant(new PVector(450, 450)));
  //ants.add(new Ant(new PVector(350, 220)));
  //ants.add(new Ant(new PVector(250, 300)));
  
  gradienten = new ArrayList<Gradient>();
  background(0);
  //noLoop();
 // frameRate(5);
}

void draw() {
  background(0);
  for(Gradient g: gradienten)
    g.drawGradient();
  paths.draw();
  for(Ant ant: ants){
    paths.addRectangle(ant.update());
    ant.render();
    //ant.edges();
    ant.boundaries();
  }
}

void mousePressed() {
  if(gradienten.size() > 2)
    gradienten.remove(0);
  gradienten.add(new Gradient(mouseX, mouseY, (int)(120 + random( 50)), false)); 

}


