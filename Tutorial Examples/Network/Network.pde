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
  int [] m_nodeIds = new int[0];
  
  int getDegree() { return m_nodeIds.length; }
}

// a basic class to define nodes
class Node extends Object
{
  Node(int id)  { m_id = id; }
  int [] m_netIds = new int[0];
  
  int getDegree() { return m_netIds.length; }
}

// a basic class to save the loaded netlist
class Network
{
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
    for(int i = 0; i < numNodes; ++i) nodes[i] = m_nodes[net.m_nodeIds[i]];
    return nodes;
  }
  
  Net[] getNetsConnectedToNode(Node node) { // get the nets connected a given node
    int numNets = node.getDegree();
    Net[] nets = new Net[numNets];
    for(int i = 0; i < numNets; ++i) nets[i] = m_nets[node.m_netIds[i]];
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
    for(int i = 0; i < nd.m_netIds.length; ++i)
    {
      if(nd.m_netIds[i] == net.getId()) return true;
    }
    return false;
  }
}