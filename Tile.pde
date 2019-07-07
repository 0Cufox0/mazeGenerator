class Tile{
  boolean visitted;
  boolean[] sides = {true, false, true, false};
  int x,y;
  public Tile(int x, int y){
    this.x        = x;
    this.y        = y;
    this.visitted = false;
  }
  
 public void drawTile(){
     int trueX = x * Grid.RES;
     int trueY = y * Grid.RES;
     //UP
     if(sides[0]){  
       line(trueX, trueY , trueX + Grid.RES, trueY); 
     }
     
     //RIGHT
     if(sides[2]){
       line(trueX + Grid.RES, trueY , trueX + Grid.RES , trueY + Grid.RES);
     }
     
   
 }
  
}
