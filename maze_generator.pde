Grid maze;
void setup(){
  size(400,400);
  maze = new Grid(width, height);
  maze.init();
}


void draw(){
  background(0);
  maze.drawGrid();
}
