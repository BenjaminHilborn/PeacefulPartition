void _solve(){
  //for all nodes
  for(int nodeNumber=0;nodeNumber<my_nodes.size();nodeNumber++){
    my_nodes.get(nodeNumber).gain = computeGain(my_nodes.get(nodeNumber));
    
  }
    //
    //create gainlist
    gainList = my_nodes;
    //order gainlist (quicksort)
    quickSort(gainList, 0, gainList.size());
    
  //for total number of moves == number of nodes
  for (int moves=0; moves<my_nodes.size();moves++){
    //is top of gainlist move allowed based on balance critera AND is not locked?
      //move
    for(int step=0;step<gainList.size();step++){
      //check balance criteria
      if(gainList.get(step).partition == 0 && abs(nodes_on_right-nodes_on_left)>maxBalanceDifference){
        continue;
      }
      else if(gainList.get(step).partition == 1 && abs(nodes_on_left-nodes_on_right)>maxBalanceDifference){
        continue;
      }
      else{  //execute move
        if(gainList.get(step).partition == 1) gainList.get(step).partition = 0;
        else gainList.get(step).partition = 1;
        //remove from gain list
        gainList.remove(step);
      }
    }
  }
  detectCuts();
  bestCuts = net_cuts;
}

void random_solve(){
  //Backup play network
  ArrayList<Float> node_x_orig = new ArrayList<Float>();
  int bestCuts = 10;
  // Back up nodes
  for (int i = 0; i<my_nodes.size(); i++){
    node_x_orig.add(my_nodes.get(i).x);
  
  }
  
  // Do this many times
  for (int j = 0; j<12; j++){
    // Randomize nodes
    for (int k = 0; k<my_nodes.size(); k++){
        int rand = (int) random(2) * 2 - 1;
        if (rand == 1)  my_nodes.get(k).x = width/2-100;
        else            my_nodes.get(k).x = width/2+100;
        
        detectNodesPerSide();
        detectCuts();
        
        if (net_cuts < bestCuts){
          double tot = nodes_on_left+nodes_on_right;
    
          if (nodes_on_left/tot > balanceMin && nodes_on_left/tot < balanceMax){
            bestCuts = net_cuts;
           }
        }
      
    }
  }
  
    for (int i = 0; i<my_nodes.size(); i++){
      my_nodes.get(i).x = node_x_orig.get(i);
    }  
    
    minCuts = bestCuts;
    println(minCuts);

}

int computeGain(Node node){
  detectCuts();
  int startCuts = net_cuts;
  if(node.partition == 0) node.partition = 1;
  else node.partition = 0;
  detectCuts();
  int endCuts = net_cuts;
  return endCuts-startCuts;
}

//  int cuts=0;
//  int newCuts=0;
//  //for all nets connected to node
//  Nodes[] nodeList = getNodesConnectedToNode(node);
//  int reference = node.partition;
//  for(int node = 1; node < nodeList.length; node++){
//    if(nodeList(node).partition != reference) cuts++;
//  }
//    //calculate if cut
//    //calculate if the move will cut
//    int new_reference = node.partition;
//  for(int nets=0;nets<node.m_netIds.length;nets++){
//    for(int nodes=0;nodes<node.m_netIds(nets).
//    if(node.m_netIds(nets).)
//    {
//      cuts++;
//    }
//  }
//  //sum all
//  //return gain
//}

public static void quickSort(ArrayList<Node> arr, int low, int high) {
    if (arr == null || arr.size() == 0)
      return;
 
//    if (low >= high)
//      return;
 
    // pick the pivot
    int middle = low + (high - low) / 2;
    Node pivot = (Node)arr.get(middle);
 
    // make left < pivot and right > pivot
    int i = low, j = high-1;
    while (i <= j) {
      while (arr.get(i).gain < pivot.gain) {
        i++;
      }
 
      while (arr.get(j).gain > pivot.gain) {
        j--;
      }
 
      if (i <= j) {
        Node temp = arr.get(i);
        arr.set(i,arr.get(j));
        arr.set(j, temp);
        i++;
        j--;
      }
    }
 
    // recursively sort two sub parts
    if (low < j)
      quickSort(arr, low, j);
 
    if (high > i)
      quickSort(arr, i, high);
  }