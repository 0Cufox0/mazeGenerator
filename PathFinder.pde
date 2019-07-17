import java.util.Queue;
import java.util.LinkedList;
class PathFinder{
 Tile current;
 Grid maze;
 
 ArrayList<Tile> path;
 ArrayList<Tile> checks;
 public PathFinder(Grid maze){
  this.maze = maze;
  this.current = maze.tileSet[0][0];
  this.path = new ArrayList<Tile>();
  this.checks = new ArrayList<Tile>();

 }
 
 public ArrayList<Tile> getNeighbours(){
   ArrayList<Tile> result = new ArrayList<Tile>();
   for(int x = -1; x < 2; x++){
      for(int y = -1; y < 2; y++){
       if(abs(x) == abs(y)){
        continue; 
       }
       if(x==0 && y ==0){
        continue; 
       }
       
       if(maze.checkValue(current.x + x,current.y + y)){
        Tile next = maze.tileSet[current.x + x][current.y + y];
        //// if x is positive check the current Tile
        //// if x is negative check the next tile
        if(x > 0){
         if(!current.sides[1]){
          result.add(next); 
         }
        }else if(x<0){
         if(!next.sides[1]){
          result.add(next); 
         } 
        }
        ////if y is positive check the next tile
        ////if y is negative check the current tile
        if(y > 0){
         if(!next.sides[0]){
          result.add(next); 
         }
        }else if(y<0){
         if(!current.sides[0]){
          result.add(next); 
         } 
        }
       }
      }
   }
   return result;
 }
 public PVector getKey(HashMap<PVector, Float> map, Float value){
   for(PVector Key : map.keySet()){
       if(map.get(Key).equals(value)){
         return Key;  
       }
   }
   return null;
 }
 float H(Tile tile){
  return (pow(maze.END.y - tile.y,2) + pow(maze.END.x - tile.x,2)); 
 }
 float D(Tile tile){

  return (tile.x - current.x) + (tile.y - current.y); 
 }
 boolean contains(Queue<Node> set, Node value){
  Queue<Node> clone = new LinkedList<Node>(set);
  while(!clone.isEmpty()){
    Node node = clone.poll();
    if((node.x == value.x) && (node.y == value.y)){
     return true; 
    }
  }
  return false;
  
 }
 void printSet(Queue<Node> set){
  Queue<Node> clone = new LinkedList<Node>(set);
  print("[");
  while(!clone.isEmpty()){
    print(clone.poll().f + ",");
  }
  print("]");
  println();
 }
 Node getMin(Queue<Node> set){
   Queue<Node> clone = new LinkedList<Node>(set);
   float minF = clone.element().f;
   Node min = clone.element();
   while(!clone.isEmpty()){
     
    Node current = clone.remove();
    if(current.f < minF){
     minF = current.f;
     min = current;
    }
   }
   return min;
 }
 Queue<Node> delete(Queue<Node> queue,Node node){
   Queue<Node> clone = new LinkedList<Node>(queue);
   Queue<Node> result = new LinkedList<Node>();
   while(!clone.isEmpty()){
    Node current = clone.poll();
    if(!current.equals(node)){
      result.add(current);
    }
   }
   return result;
 }
  ArrayList<Tile> getPath( HashMap<Tile, Tile> previous,Tile tile){
    Tile temp = tile;
    ArrayList<Tile> p = new ArrayList<Tile>();
    while(previous.get(temp)!=null){
      p.add(temp);
      temp = previous.get(temp);
    }
    return p;
  }
  
 void findPath(){
  
  float currentF =  H(current);
  Queue<Node> openSet = new LinkedList<Node>();
  HashMap<PVector, Float> mapG = new HashMap<PVector, Float>();
  HashMap<PVector, Float> mapF = new HashMap<PVector, Float>();
  HashMap<Tile, Tile> previous = new HashMap<Tile, Tile>();
  HashMap<Tile, Boolean> visitted = new HashMap<Tile, Boolean>();
  for(int x = 0;x < width/ Grid.RES; x++){
   for(int y = 0; y < height/ Grid.RES; y++){
    mapF.put(new PVector(x,y),Float.POSITIVE_INFINITY);
    mapG.put(new PVector(x,y),Float.POSITIVE_INFINITY);
    visitted.put(maze.tileSet[x][y],false);
   }
  }
  openSet.add(new Node(current.x, current.y, currentF));
  mapG.replace(new PVector(current.x, current.y), 0.0);
  mapF.replace(new PVector(current.x, current.y), currentF);
  previous.put(current, null);
  while(!openSet.isEmpty()){    
    Node min = getMin(openSet);
    visitted.replace(current, true);
    current = maze.tileSet[min.x][min.y];
    openSet = delete(openSet, min);
    
    if(current.x == maze.END.x && current.y == maze.END.y){
      path = getPath(previous,current);
      return;
    }
    for(Tile neighbour : getNeighbours()){
      if(visitted.get(neighbour)){
       continue; 
      }
      checks.add(neighbour);
      float neighbourG = mapG.get(new PVector(current.x, current.y)) + D(neighbour);
       if(neighbourG < mapG.get(new PVector(neighbour.x, neighbour.y))){
         float neighbourF = neighbourG + H(neighbour);
         previous.put(neighbour,current);
         mapG.replace(new PVector(neighbour.x, neighbour.y), neighbourG);
         mapF.replace(new PVector(neighbour.x, neighbour.y), neighbourF); 
           if(!contains(openSet,new Node(neighbour.x, neighbour.y, neighbourF))){
             openSet.add(new Node(neighbour.x, neighbour.y, neighbourF));
         }
     } 
      
           
    }
  }
 }
 
 boolean stop = false;
 int lastI = 0;
 int count = 0;
 void show(){

  
   int i = lastI;
   if(!stop){
     i = ((count++/1) % checks.size());
   }
    for(int j = 0; j < i;j++){
      fill(0,0,100);
      Tile tile = checks.get(j);
      rect(tile.x * Grid.RES, tile.y * Grid.RES, Grid.RES, Grid.RES); 
    }
    Tile tile = checks.get(i);
    fill(0,0,255);
    rect(tile.x * Grid.RES, tile.y * Grid.RES, Grid.RES, Grid.RES); 
    if(tile.x == maze.END.x && tile.y==maze.END.y){
     stop = true;
     lastI = i;
      for(Tile thing : path){
     fill(0,100,0);
      rect(thing.x * Grid.RES, thing.y * Grid.RES, Grid.RES, Grid.RES); 
     }
    }
 }
  
}
