//void _solve(){
//  //for all nodes
//  for(int nodeNumber=0;nodeNumber<my_nodes.length;nodeNumber++){
//    my_nodes.get(nodeNumber).gain = computeGain(my_nodes.get(nodeNumber));
    
//  }
//    //
//    //create gainlist
//    ArrayList gainList = my_nodes;
//    //order gainlist (quicksort)
//    quickSort(gainList, 0, numberOfNodes);
    
//  //for total number of moves == number of nodes
//  for (int moves=0; moves<my_nodes.length;moves++){
//    //is top of gainlist move allowed based on balance critera AND is not locked?
//      //move
//    for(int step=0;step<gainList.length; step++){
//      //check balance criteria
//      if(
//    }
//    //else step though gainlist till move is found
//  }
//}

//int computeGain(Node node){
//  //for all nets connected to node
//    //calculate if cut
//    //calculate if the move will cut
//  //sum all
//  //return gain
//}

//public static void quickSort(ArrayList arr, int low, int high) {
//    if (arr == null || arr.length == 0)
//      return;
 
//    if (low >= high)
//      return;
 
//    // pick the pivot
//    int middle = low + (high - low) / 2;
//    int pivot = arr[middle];
 
//    // make left < pivot and right > pivot
//    int i = low, j = high;
//    while (i <= j) {
//      while (arr[i].gain < pivot.gain) {
//        i++;
//      }
 
//      while (arr[j].gain > pivot.gain) {
//        j--;
//      }
 
//      if (i <= j) {
//        int temp = arr[i];
//        arr[i] = arr[j];
//        arr[j] = temp;
//        i++;
//        j--;
//      }
//    }
 
//    // recursively sort two sub parts
//    if (low < j)
//      quickSort(arr, low, j);
 
//    if (high > i)
//      quickSort(arr, i, high);
//  }