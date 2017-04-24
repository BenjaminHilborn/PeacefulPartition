void draw_text(){
  textFont(myFont);
  int text_size = 16;
  textSize(text_size);
  fill(255,255,255); //set text to white
  int text_shift = 10; // pixels away from edge of screen

  textAlign(RIGHT, TOP);  
  text("Required Score: "+"FILL IN COMPS BEST", width-text_shift, text_shift);
  
  textAlign(RIGHT, TOP);  
  text("Your Score: "+net_cuts, width-text_shift, text_shift+text_size);
  
  if (mode != 3)
  {
    textAlign(RIGHT, BOTTOM);  
    text("Nodes: "+nodes_on_right, width-text_shift, height-text_shift);
    
    textAlign(LEFT, BOTTOM);  
    text("Nodes: "+nodes_on_left, text_shift, height-text_shift);
  }
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

void draw_back_button(){
    ellipseMode(CENTER);
    noStroke();
    fill(255,255,255);          ellipse(40, 40, CIRCLE_SIZE+5, CIRCLE_SIZE+5);
    //fill(0,0,0);                ellipse(35, 35, CIRCLE_SIZE+2, CIRCLE_SIZE+2);
    fill(my_nodes.get(0).c);    ellipse(40, 40, CIRCLE_SIZE, CIRCLE_SIZE);

    fill(0,0,0);
    textSize(13);
    textAlign(CENTER, CENTER);  
    text("Main\nMenu", 40+1, 40+1-3);
    fill(255,255,255);
    text("Main\nMenu", 40, 40-3);
}

void draw_complete(){
  stroke(255,255,255);
  fill(my_nodes.get(0).c);  ellipse(width/2, height/2, CIRCLE_SIZE*2, CIRCLE_SIZE*2);
  
  fill(0,0,0);
  textSize(16);
  textAlign(CENTER, CENTER);  
  text("Play Again", width/2+1, height/2+1);
  
  fill(255,255,255);
  textSize(16);
  textAlign(CENTER, CENTER);  
  text("Play Again", width/2, height/2);
}

void draw_complete_title(){
 // rectMode(CENTER);
  //fill(0,0,0,155);
  //rect(width/2,height/2,width,height);
  
  noStroke();
  for (int i = 0; i<5; i++)
  {
  fill(255,255,255,255);  ellipse(width/2-100+i*48, height/2-190, CIRCLE_SIZE*2+8, CIRCLE_SIZE*2+8);
  }
  
  for (int i = 0; i<5; i++)
  {
    ellipseMode(CENTER);
    fill(my_nodes.get(i).c);
    ellipse(width/2-100+i*48, height/2-190, CIRCLE_SIZE*2, CIRCLE_SIZE*2) ;
  }
  
  textFont(myFont);
  
  textSize(32);
  fill(0,0,0); //set text to white
  textAlign(CENTER, CENTER);   
  text("Level Complete!", width/2+1, height/2-200+1);
  //text("Peaceful Partition", width/2-1, height/2-200-1);
  //text("Peaceful Partition", width/2-1, height/2-200+1);
  //text("Peaceful Partition", width/2+1, height/2-200-1);
  fill(255,255,255);           text("Level Complete!", width/2, height/2-200);
  
}