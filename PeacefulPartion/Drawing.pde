void draw_text(){
  textFont(myFont);
  int text_size = 16;
  textSize(text_size);
  fill(255,255,255); //set text to white
  int text_shift = 10; // pixels away from edge of screen

  textAlign(RIGHT, TOP);  
  text("Goal: "+bestCuts, width-text_shift, text_shift);
  
  textAlign(RIGHT, TOP);  
  text("Net Cuts: "+net_cuts, width-text_shift, text_shift+text_size);
  
  textAlign(RIGHT, BOTTOM);  
  text("Nodes: "+nodes_on_right, width-text_shift, height-text_shift);
  
  textAlign(LEFT, BOTTOM);  
  text("Nodes: "+nodes_on_left, text_shift, height-text_shift);
}

void draw_partition(){
  strokeWeight(4);
  stroke(204, 102, 0);
  line(width/2.0, 0, width/2.0, height);
}

void draw_nodes(){
    for (int i=0; i < my_nodes.size(); i++) {
    if (bover && whichImage==i) 
      stroke(255);  // white
    else
      noStroke(); 
    ellipseMode(CENTER);
    fill(my_nodes.get(i).c);
    ellipse ( my_nodes.get(i).x, my_nodes.get(i).y, my_nodes.get(i).size, my_nodes.get(i).size) ;
  }
}

void draw_nets(){
    strokeWeight(4);
  stroke(204, 102, 0);
  for (int i=0; i < my_nets.size(); i++) {
    if(my_nets.get(i).m_nodeIds.size() == 2){
      stroke(255);
      line(playNetwork.getNode(my_nets.get(i).m_nodeIds.get(0)).x, playNetwork.getNode(my_nets.get(i).m_nodeIds.get(0)).y,
           playNetwork.getNode(my_nets.get(i).m_nodeIds.get(1)).x, playNetwork.getNode(my_nets.get(i).m_nodeIds.get(1)).y);
    }
    
    if(my_nets.get(i).m_nodeIds.size() > 2){
      //calculate centre
      float totalX=0;
      float totalY=0;
      float centreX=0;
      float centreY=0;
      for(int j = 0; j< my_nets.get(i).m_nodeIds.size(); j++){
        totalX += playNetwork.getNode(my_nets.get(i).m_nodeIds.get(j)).x;
        totalY += playNetwork.getNode(my_nets.get(i).m_nodeIds.get(j)).y;
      }
      
      //average out the X and Y coordiates of all nodes connected to that net
      centreX=totalX/my_nets.get(i).m_nodeIds.size();
      centreY=totalY/my_nets.get(i).m_nodeIds.size();
      
      //draw a line from the centre to each node
      for(int j = 0; j< my_nets.get(i).m_nodeIds.size(); j++){
        stroke(255);
        line(centreX, centreY, playNetwork.getNode(my_nets.get(i).m_nodeIds.get(j)).x,playNetwork.getNode(my_nets.get(i).m_nodeIds.get(j)).y);
      }
    }
    
    if(my_nets.get(i).m_nodeIds.size() < 2){
      println("Error: Net is only connected to one node!");
    }
  }
}