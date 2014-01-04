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


