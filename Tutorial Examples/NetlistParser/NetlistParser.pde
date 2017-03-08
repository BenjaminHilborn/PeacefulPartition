class NetlistParser {
  String  [] m_fileLines;
  
  Network m_network;
  
  NetlistParser(Network net)
  {
    m_network = net;
  }
  
  int parse(String fileName)
  {
    Integer currentLine = 0;
    m_fileLines = loadStrings(fileName);
    if(parseNumberOfNodes(currentLine) != 0)
    {
      return 1;
    } else {
      println("The number of nodes: ", m_network.getNumberOfNodes());
    }
    
    if(parseNumberOfNets(currentLine) != 0)
    {
      return 1;
    } else {
      println("The number of nets: ", m_network.getNumberOfNets());
    }
    
    if(parseNetConnections(currentLine) != 0)
    {
      return 1;
    }
    
    return 0;
  }
  
  int parseNumberOfNets(Integer currentLine) {
    for(int i = currentLine; i < m_fileLines.length; ++i)
    {
      if(m_fileLines[i].indexOf("nets:") >= 0)
      {
        String [] tokens = tokenize(m_fileLines[i]);
        if(tokens.length < 2) {
          println("Error in reading the input file for parsing the number of nets!");
          return 1;
        }
        int numNets = int(tokens[1]); // the number is indicated by the second token
        m_network.m_nets = new Net[numNets]; // create array
        for(int j = 0; j < numNets; ++j)
        {
          m_network.m_nets[j] = new Net(j); // create each net
        }
        currentLine = i + 1; // update the current line
        return 0;
      }
    }
    return 1;
  }
  
  int parseNumberOfNodes(Integer currentLine) {
    for(int i = currentLine; i < m_fileLines.length; ++i)
    {
      if(m_fileLines[i].indexOf("nodes:") >= 0)
      {
        String [] tokens = tokenize(m_fileLines[i]);
        if(tokens.length < 2) {
          println("Error in reading the input file for parsing the number of nodes");
          return 1;
        }
        int numNodes = int(tokens[1]); // the number is indicated by the second token
        m_network.m_nodes = new Node[numNodes]; // create the array
        for(int j = 0; j < numNodes; ++j)
        {
          m_network.m_nodes[j] = new Node(j); // create each node
        }
        currentLine = i + 1; // update the current line
        return 0;
      }
    }
    return 1;
  }
  
  int parseNetConnections(Integer currentLine) {
    int netCount = 0;
    for(int i = currentLine; i < m_fileLines.length; ++i)
    {
      String [] tokens = tokenize(m_fileLines[i]);
      if(tokens.length > 0 && tokens[0].equals("net"))
      {
        if(tokens.length < 4) 
        {
          println("Error in reading the input file for parsing the number of nodes!");
          return 1;
        }
        int netId = int(tokens[1]); 
        Net currentNet = m_network.getNet(netId);
        for(int j = 3; j < tokens.length; ++j)
        {
          int nodeId = int(tokens[j]);
          Node currentNode = m_network.getNode(nodeId);
          currentNet.m_nodeIds = append(currentNet.m_nodeIds, nodeId);
          currentNode.m_netIds = append(currentNode.m_netIds, netId);
        }
        ++netCount;
      }
    }
    currentLine = m_fileLines.length;
    if(netCount == m_network.getNumberOfNets())
    {
      return 0;
    } else {
      println("Error in reading the input file: the number of nets and parsed are not equal!", netCount);
      return 1;
    }
  }
  
  String[] tokenize(String str)
  {
    String [] tokens = new String[0];
    
    for(int i = 0; i < str.length(); ++i)
    {
      while(i < str.length() && str.charAt(i) == ' ') ++i;
      if(i == str.length()) break;
      int start = i;
      while(i < str.length() && str.charAt(i) != ' ') ++i;
      int end = i;
      tokens = append(tokens, str.substring(start, end));
    }
    
    return tokens;
  }
}