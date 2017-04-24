void _solve(){
  //for all nodes
  for(int nodeNumber=0;nodeNumber<numberOfNodes;nodeNumber++){
    my_nodes.get(nodeNumber).gain = computeGain(my_nodes.get(nodeNumber));
    
  }
    //
    //create gainlist
    //order gainlist
  //for total number of moves == number of nodes
    //is top of gainlist move allowed based on balance critera AND is not locked?
      //move
    //else step though gainlist till move is found
    
}

int computeGain(Node node){
  //for all nets connected to node
    //calculate if cut
    //calculate if the move will cut
  //sum all
  //return gain
}