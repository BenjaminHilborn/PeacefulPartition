void _solve(){
  //for all nodes
  for(int nodeNumber=0;nodeNumber<my_nodes.length;nodeNumber++){
    my_nodes.get(nodeNumber).gain = computeGain(my_nodes.get(nodeNumber));
    
  }
    //
    //create gainlist
    ArrayList gainList = my_nodes;
    //order gainlist (quicksort)
    quickSort(gainList, 0, numberOfNodes);
    
  //for total number of moves == number of nodes
  for (int moves=0; moves<my_nodes.length;moves++){
    //is top of gainlist move allowed based on balance critera AND is not locked?
      //move
    for(int step=0;step<gainList.length, step++){
      //check balance criteria
      if(gainList(step).partition == 0 && abs(nodes_on_right-nodes_on_left)>maxBalanceDifference){
        continue;
      }
      else if(gainList(step).partition == 1 && abs(nodes_on_left-nodes_on_right)>maxBalanceDifference){
        continue;
      }
      else{  //execute move
        if(gainList(step).partition == 1) gainList(step).partition == 0;
        else gainList(step).partition == 1;
        //remove from gain list
        gainList.remove(step)
      }
    }
  }
}

//int computeGain(Node node){
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

bool isNetCut(Net net){
  for(){ //all nodes connected to net
    getNodesConnectedToNet(Net net)
  }
}

public static void quickSort(ArrayList arr, int low, int high) {
    if (arr == null || arr.length == 0)
      return;
 
    if (low >= high)
      return;
 
    // pick the pivot
    int middle = low + (high - low) / 2;
    int pivot = arr[middle];
 
    // make left < pivot and right > pivot
    int i = low, j = high;
    while (i <= j) {
      while (arr[i].gain < pivot.gain) {
        i++;
      }
 
      while (arr[j].gain > pivot.gain) {
        j--;
      }
 
      if (i <= j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
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