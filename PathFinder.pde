class PathFinder{
 Tile current;
 Grid maze;
 Tree<Tile> nodes;
 ArrayList<Tile> path;
 public PathFinder(Grid maze){
  this.maze = maze;
  this.current = maze.tileSet[0][0];
  this.nodes = new Tree<Tile>(this.current);
  this.current.visitted = true;
  this.path = new ArrayList<Tile>();
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
        
        
        if(next.visitted){
          continue; 
        }
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
 boolean isStuck(){
  return getNeighbours().size() == 0; 
 }
 
 void findPath(){
  ArrayList<Tile> path = new ArrayList<Tile>();
  ArrayList<Tile> neighbours = getNeighbours();
  for(Tile tile : neighbours){
    if(current.x == maze.END.x && current.y == maze.END.y){
      
       return; 
     }
     nodes.addSon(tile);
     nodes = nodes.getSon();
     current = nodes.getValue();
     current.visitted = true;
     this.path.add(current);
     
       
     findPath();
     
  }
   
 }
 
 boolean stop = false;
 int lastI = 0;
 int count = 0;
 void show(){
   int i = lastI;
   if(!stop){
     i = ((count++/1) % path.size());
   }
    for(int j = 0; j < i;j++){
      fill(0,0,100);
      Tile tile = path.get(j);
      rect(tile.x * Grid.RES, tile.y * Grid.RES, Grid.RES, Grid.RES); 
    }
    Tile tile = path.get(i);
    fill(0,0,255);
    rect(tile.x * Grid.RES, tile.y * Grid.RES, Grid.RES, Grid.RES); 
    if(tile.x == maze.END.x && tile.y==maze.END.y){
     stop = true;
     lastI = i;
    }
 }
  
}
