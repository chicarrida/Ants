public static class Collision {
  private static ArrayList<Ant> ants;
  public static void setAnts(ArrayList<Ant>_ants) {
    ants = _ants;
  }

  public static void checkCollission() {
    for (int i = 0; i < ants.size (); i++) {
      for (int j= i+1; j < ants.size (); j++) {
        PVector d = getDistance(ants.get(i), ants.get(j));
        if (d.mag() < 20) {
          println("collission detected");
          ants.get(i).correctPath(d);
          ants.get(j).correctPath(d);
        }
      }
    }
  }
  private static PVector getDistance(Ant first, Ant second) {
    float xDist = first.location.x - second.location.x;
    float yDist = first.location.y - second.location.y;
    return new PVector(xDist, yDist);
  }
}
