import java.util.Arrays;

// a basic class that has Id number
class Object
{
  int m_id;
  int getId()     { return m_id; } 
}


// a basic class to define Nets
class Net extends Object
{
  Net(int id) { m_id = id; }
  //int [] m_nodeIds = new int[0];
  IntList m_nodeIds = new IntList();
  
  int getDegree() { return m_nodeIds.size(); }
  
  int weight;
}

// a basic class to define nodes
class Node extends Object
{
  Node(int id, float tempPlacedX, float tempPlacedY)  
  { 
    m_id = id; 
    c = color(random(128)+100,random(128)+100,random(128)+100);
    x = tempPlacedX;
    y = tempPlacedY;
   // currentX = tempCurrentX;
    //currentY = tempCurrentY;
    randomWalkX=random(10.0);
    randomWalkY=random(10.0);
    size=random(70,100);
    soundFreq=random(0);
  }
  
  
  IntList m_netIds = new IntList();
  
  int getDegree() { return m_netIds.size(); }
  
  color c;
  float x;
  float y;
  float currentX;
  float currentY;
  float randomWalkX;
  float randomWalkY;
  float size;
  float soundFreq;
}

// a basic class to save the loaded netlist
class customNetwork
{
  customNetwork(int difficulty){
    switch(difficulty){
      case 0: 
        int numberOfNodes=5;
        int numberOfNets=5;
        int numberOfConnectionsAllowed = 10; //must be >= numberOfNets + numberOfNodes
        int numberOfConnectionsMade = 0;
        
        //make nodes
        my_nodes = new ArrayList<Node>();
        for(int i=0;i<numberOfNodes;i++){
          my_nodes.add(new Node(i, width*random(0.0,1.0),height*random(0.0,1.0)));
        }
        
        //make nets
        my_nets = new ArrayList<Net>();
        for(int i=0;i<numberOfNets;i++){
          my_nets.add(new Net(i));
        }
        
        //make random connections
        while(numberOfConnectionsMade != numberOfConnectionsAllowed){
          //if any node has no connections, connect it first
            for(int nodeNumber=0;nodeNumber<numberOfNodes;nodeNumber++){
              if (my_nodes.get(nodeNumber).m_netIds.size() == 0){
                int netNumber = int(random(0,numberOfNets));
                //add net to node
                my_nodes.get(nodeNumber).m_netIds.append(netNumber);
                //add node to net
                my_nets.get(netNumber).m_nodeIds.append(nodeNumber);
                numberOfConnectionsMade++;
              }
            }
            
          //if any net has no connections, connect it
          for(int netNumber=0;netNumber<numberOfNets;netNumber++){
              if (my_nets.get(netNumber).m_nodeIds.size() == 0){
                int nodeNumber = int(random(0,numberOfNodes));
                //add node to net
                my_nets.get(netNumber).m_nodeIds.append(nodeNumber);
                //add net to node
                my_nodes.get(nodeNumber).m_netIds.append(netNumber);
                numberOfConnectionsMade++;
              }
            }
            
          //else connect at random
          int netNumber = int(random(0,numberOfNets));
          int nodeNumber = int(random(0,numberOfNodes));
          //add node to net
          my_nets.get(netNumber).m_nodeIds.append(nodeNumber);
          //add net to node
          my_nodes.get(nodeNumber).m_netIds.append(netNumber);
          numberOfConnectionsMade++;
        }
        break;
      case 1:
        
        break;
      case 2:
        
        break;
      case 3:
        
        break;
       default:
         println("Error: Incorrect difficulty setting!");
    }
    
  }
  
  Net  [] m_nets  = new Net[0];  // design nets in the design
  Node [] m_nodes = new Node[0]; // defined nodes in the design
  
  int getNumberOfNodes() { return m_nodes.length; }
  int getNumberOfNets () { return m_nets.length;  }
  
  public Node getNode(int id) {
    if(id < getNumberOfNodes() )
    {
      return m_nodes[id];
    }
    println("Error: the node does not exist! Requested id: ", id);
    exit();
    return m_nodes[0];
  }
  
  
  public Net getNet(int id) {
    if(id < getNumberOfNets() )
    {
      return m_nets[id];
    }
    println("Error: the net does not exist! Requested id: ", id);
    exit();
    return m_nets[0];
  }
 
  Node[] getNodesConnectedToNet(Net net) { // get the nodes connected to a given net
    int numNodes = net.getDegree();
    Node[] nodes = new Node[numNodes];
    for(int i = 0; i < numNodes; ++i) nodes[i] = m_nodes[net.m_nodeIds.get(i)];
    return nodes;
  }
  
  Net[] getNetsConnectedToNode(Node node) { // get the nets connected a given node
    int numNets = node.getDegree();
    Net[] nets = new Net[numNets];
    for(int i = 0; i < numNets; ++i) nets[i] = m_nets[node.m_netIds.get(i)];
    return nets;
  }
  
  Node[] getNodesConnectedToNode(Node node) {
    int[]  idList = new int[0];
    Node[] list = new Node[0];
    Net[]  nets = getNetsConnectedToNode(node);
    for(int i = 0 ; i < nets.length; ++i)
    {
      Node [] nodes = getNodesConnectedToNet(nets[i]);
      for(int j = 0; j < nodes.length; ++j)
      {
        if(nodes[j].getId() != node.getId()) // make sure that we are not adding the original node to the list
        {
          idList = append(idList, nodes[j].getId());
          //list = (Node[])append(list, nodes[j]);
        }
      }
    }
    // sort the list and then find a list with unique id numbers
    Arrays.sort(idList);
    int lastId = -1;
    for(int i = 0 ; i < idList.length; ++i)
    {
      if(idList[i] > lastId)
      {
        lastId = idList[i];
        list = (Node[])append(list, getNode(lastId));
      }
    }
    return list;
  }
  
  // this method assus that n1 is connected to n2 using a net
  Net getNetConnectingNodes(Node n1, Node n2)
  {
    Net[] nets = getNetsConnectedToNode(n1);
    for(int i = 0; i < nets.length; ++i)
    {
      if(isNodeConnectedToNet(n2, nets[i]) == true)
      {
        return nets[i];
      }
    }
    println("Error: two nodes are not connected!");
    exit();
    return nets[0]; // this must not happen
  }
  
  boolean isNodeConnectedToNet(Node nd, Net net)
  {
    for(int i = 0; i < nd.m_netIds.size(); ++i)
    {
      if(nd.m_netIds.get(i) == net.getId()) return true;
    }
    return false;
  }
}