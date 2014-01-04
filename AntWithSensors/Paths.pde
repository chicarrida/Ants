public class Paths{
 ArrayList list;

public Paths(){
 list = new ArrayList();
}
public void addRectangle(Rectangle rect){
 list.add(rect);  
}

public int size(){
  return list.size();
}

public void draw(){
    for(int i = 0; i < list.size(); i++){ 
      Rectangle rect = (Rectangle)list.get(i);      
      rect.draw();      
      if(rect.getStrength() < 0){
        // remove from list
        list.remove(i);
      }
    }
  }
}
