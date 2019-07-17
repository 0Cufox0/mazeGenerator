
import java.util.Comparator;
class compareNode implements Comparator<Node>{

  @Override public int compare(Node a, Node b){
     return Float.compare(a.f, b.f);
  }
}
class Node{
 int x;
 int y;
 float f;
 public Node(int x, int y, float f){
  this.x = x;
  this.y = y;
  this.f = f;
 }
  
}
