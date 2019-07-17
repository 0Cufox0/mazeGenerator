Grid maze;
PathFinder find;
void setup(){
  size(400,400);
  maze = new Grid(width, height);
  maze.init();
  
}
boolean once = true;
void mousePressed(){
 once = true; 
 //find.count = 0;
 maze.END = new PVector(mouseX/Grid.RES, mouseY/Grid.RES);
}
void draw(){
  background(0);
  if(!maze.isDone){
     maze.generate();
  }else{
    if(once){
     once = false;
     find = new PathFinder(maze);
     find.findPath(); 
    }
   find.show();   
  } 
  maze.drawGrid();
  
  
 
}
