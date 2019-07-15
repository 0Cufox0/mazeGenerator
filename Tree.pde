class Tree<Type>{
  Type value;
  ArrayList<Tree<Type>> children;
  int count;
  Tree(Type value){
   this.value = value;
   this.count = 0;
   this.children = new ArrayList<Tree<Type>>();
  }
  
  void addSon(Type value){
   children.add(new Tree<Type>(value)); 
  }
  
  Tree<Type> getSon(){
   return this.children.get(count++); 
  }
  
  Type getValue(){
   return this.value; 
  }
}
