Gradient g1;
Gradient g2;
Ant ant;
Ant ant2;
Ant ant3;

int counter = 0;
Paths paths;
void setup() {
  paths = new Paths();
  size(500, 500);
  ant = new Ant(new PVector(400, 180));
  ant2 = new Ant(new PVector(400, 220));
  ant3 = new Ant(new PVector(400, 300));
  
  g1 = new Gradient();
  g2 = new Gradient(400, 300, 140, false);
  
  background(0);
  //noLoop();
}

void draw() {
  background(0);
  g1.drawGradient();
  g1.drawGradient();  
  g2.drawGradient();
  
  if (counter < 100) {
    paths.addRectangle(ant.move());
    paths.addRectangle(ant2.move());    
  } 
 if(counter < 250)
  paths.addRectangle(ant3.move());
  
  counter++;
  paths.draw();
  ant.draw();
  ant2.draw();
  ant3.draw();
}
