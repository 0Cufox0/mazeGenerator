import java.util.Stack;
class Grid{
  final static int RES = 5;
  PVector END ;
  Stack visitted;
  Tile current;
  Tile[][] tileSet;
  int gridWidth;
  int gridHeight;
  boolean isDone = false;
  public Grid(int W, int H){
   gridWidth  = W / RES;
   gridHeight = H / RES;
   tileSet    = new Tile[gridWidth][gridHeight];
   END = new PVector(gridWidth - 1, gridHeight - 1);
   visitted = new Stack();  
  }
  boolean checkValue(int x, int y){
   return ((x>=0 && x<gridWidth) && (y>=0 && y<gridHeight)); 
  }
  
  ArrayList<Tile> getNear(){
    ArrayList<Tile> result = new ArrayList<Tile>();
    for(int x = -1; x<2; x++){
     for(int y = -1; y<2; y++){
       if(abs(x) == 1 && abs(y) == 1){
        continue; 
       }
      int newX = current.x + x;
      int newY = current.y + y;
      if(checkValue(newX, newY)){
       if(!tileSet[newX][newY].visitted){
         result.add(tileSet[newX][newY]);
       }
      }
     }
    }
    return result;
  }
  int sign(int num){
   if(num>=0){
    return 1; 
   }
   return -1;
  }
  Tile getNext(){
   ArrayList<Tile> near = getNear();
   if(near.size() != 0){
   Tile random = near.get(int(random(near.size())));
   return tileSet[random.x][random.y];
   }
   if(visitted.isEmpty()){
     isDone = true;
     reset();
     return current;
     
   }
   current = (Tile)visitted.pop();
   
   return getNext();
  }
  void reset(){
   for(int x = 0; x < width/Grid.RES;x++){
    for(int y = 0; y < height/Grid.RES; y++){
       tileSet[x][y].visitted = false; 
    }
   }
  }
  void generate(){
    Tile next = getNext();
    int xDir = next.x - current.x;
    int yDir = next.y - current.y;
    if(xDir==1){
     current.sides[1] = false;
    }else if(xDir == -1){
     next.sides[1] = false;
    }
    if(yDir == 1){
     next.sides[0] = false;
    }else if(yDir == -1){
     current.sides[0] = false;
    }
    current = tileSet[next.x][next.y];
    current.visitted = true;
    visitted.push(current);
  }
  
  
  void init(){
    for(int y = 0; y < gridHeight; y++){
     for(int x = 0; x < gridWidth; x++){
      tileSet[x][y] = new Tile(x, y); 
     }
    }
   current = tileSet[0][0];
   current.visitted = true;
   visitted.push(tileSet[0][0]);
  }
   
  void drawGrid(){
    
    stroke(255);
    strokeWeight(1);
     for(int y = 0; y < gridHeight; y++){
       for(int x = 0; x < gridWidth; x++){
        tileSet[x][y].drawTile(); 
       }
     }
    noStroke();
    fill(255,0,255);
    rect(current.x * RES, current.y * RES, RES, RES);
    fill(0,255,0);
    rect(END.x * RES, END.y * RES, RES, RES);
  }
}
