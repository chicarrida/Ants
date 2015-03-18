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
  if (gradient == null && bg == null) {
    drawBasicBackground();
  } else if (bg != null && gradient == null) {    
    drawBackground();
  } else {    
    addGradientAndDrawBackground();
  }
  drawTargets();
  drawHome();
  paths.draw();
  processAnts();
}

void mousePressed() {  
  gradient = new Gradient(mouseX, mouseY, (int)(120 + random( 50)), false);
  targets.add(new PVector(mouseX, mouseY));
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    gradient = null;
    bg = null; 
    targets.clear();
  }
}


private void drawBasicBackground() {
  background(0);
  bg = get();
}

private void drawBackground() {
  background(0);
  tint(255, counter);
  counter -= 0.2;
  image(bg, 0, 0); 
  if (counter <= 45) {
    counter = 255;
    targets.clear();
    bg = null;
  }
}

private void  addGradientAndDrawBackground() {
  background(0);
  tint(255, counter);
  counter = 255;
  image(bg, 0, 0);
  gradient.drawGradient();
  bg = get();
  gradient = null;
}

private void drawTargets() {
  fill(255, 0, 0, 180);
  noStroke();
  for (PVector target : targets) {
    ellipse(target.x, target.y, 5, 5);
  }
}

private void drawHome() {
  fill(120, 120, 220);
  ellipse(width/2, height/2, 10, 10);
}

private void processAnts() {
  for (Ant ant : ants) {
    paths.addRectangle(ant.update());
    ant.render();
    ant.boundaries();
  }
}
