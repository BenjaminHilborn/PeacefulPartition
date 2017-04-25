
float CIRCLE_SIZE = 50; 

int window_width = 960;
int window_height = 540;
boolean bover = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 
float newx, newy;
int whichImage;
int BG_A=25;
int score = 500;
int nodes_on_right = 0;
int nodes_on_left = 0;
int net_cuts = 0;
int mode = 0; // 0 == main menu, 1 = about, 2 = play
PFont myFont;
int bestCuts=0;
int minCuts = 3;
float balanceMin = 0.4;
float balanceMax = 0.6;


customNetwork playNetwork;
ArrayList<Node> my_nodes;
ArrayList<Net> my_nets;
ArrayList<Node> gainList;

void setup() 
{
  myFont = createFont("Georgia", 128);
  

  newNetwork(0);  
  //_solve(); //algorithmically generate best solution

  
  soundSetup();
  
  background(BG_A);
  
  imageMode (CENTER);
  size(960,540); // 960x540 will be final resolution
  
  fill(153);
}
 
void draw() 
{ 
  //background(BG_A);
  backgroundController();
  soundController();

  node_collision_check(); // checks all nodes to see if they collide with each other
  node_collision_edge();
  draw_nets();
  draw_nodes(); // draw nodes
  
  if (mode == 0){
    draw_mm();
  }
  
  if (mode == 1){
    
    draw_title();
    draw_about();
    draw_about_text();
    draw_back_button();    
  }
  
  if (mode == 2){
    
    draw_partition();
    detectCuts();
    detectNodesPerSide();
    draw_text();
    draw_back_button();
    checkComplete();
  }
  
  if (mode == 3){
    draw_partition();
    detectCuts();
    detectNodesPerSide();
    noStroke();
    rectMode(CENTER);
    fill(0,0,0,155);
    rect(width/2,height/2,width,height);
    draw_text();
    draw_complete();
    draw_complete_title();
    draw_back_button();
    
    
  }

}


void backgroundController(){
  if(locked && BG_A<220) BG_A++;
  if(!locked && BG_A>0) BG_A--;
  background(BG_A);
}
 
void mousePressed() {
  
  if (mode == 0){
    
    // Play
    if (dist(mouseX,mouseY,width/2 - 100, height/2) < CIRCLE_SIZE ){
      mode = 2;
      newNetwork(0); 
    }
    
    // About
   else if (dist(mouseX,mouseY,width/2 + 100, height/2) < CIRCLE_SIZE ){
      mode = 1;
    }
  }
  
  if (mode == 1){
          if (dist(mouseX,mouseY,40,40) < CIRCLE_SIZE ){
        mode = 0;
    }
  }
  
  if (mode == 2){
    
    checkOver();
    if (bover) { 
      locked = true;
    } 
    else {
      locked = false;
      
      // Main Menu Button
      if (dist(mouseX,mouseY,40,40) < CIRCLE_SIZE ){
        mode = 0;
         newNetwork(0);  
    }
    
    }
  }
  
  if (mode == 3){
      if (dist(mouseX,mouseY,width/2, height/2) < CIRCLE_SIZE ){
      newNetwork(0); 
      mode = 2;
      
    }
  }
  
}
 
void mouseReleased() {
  locked = false;
  bover = false;
}

void mouseDragged() {
  
  if (mode == 2){
    if (locked) {
    newx = mouseX; 
    newy = mouseY;
    }
   
    my_nodes.get(whichImage).x = newx;
    my_nodes.get(whichImage).y = newy;
  }

}

void checkOver() {
  for (int i=0; i < my_nodes.size(); i++) {
    
    bover = false;
    
    // Test if the cursor is over the node  
    if (dist(mouseX,mouseY,my_nodes.get(i).x,my_nodes.get(i).y) < my_nodes.get(i).size/2 )
    {
     // println ("mouseover image: "+i);
      whichImage=i;
      bover = true;  
      sine.freq(my_nodes.get(i).soundFreq);
      break; // leave here !!!!!!!!!!!!!!!!!
    } 
  }
}


void detectCuts(){

  int cuts = 0;
  int value; // this counts how many cells are in right vs left. Right side increments, left decrements
  //int prev_cut_side = 0; // -1 = left, 1 = right
  
  for (int i=0; i < my_nets.size(); i++) {
    
     value = 0;
     int size = my_nets.get(i).m_nodeIds.size();
     for(int j = 0; j< size; j++){
       
         float x = playNetwork.getNode(my_nets.get(i).m_nodeIds.get(j)).x;
         if ( x > width/2) value++;
         else  value--;
       }
       
       if ( size != value && size != -value)  cuts++;       
     }
     
     net_cuts = cuts;
}

void checkComplete(){
  if (net_cuts <= minCuts){
    double tot = nodes_on_left+nodes_on_right;
    
    if (nodes_on_left/tot > balanceMin && nodes_on_left/tot < balanceMax){
      mode = 3; 
    }
   
  }
}

int checkCompleteInt(){
  int val = 0;
  
  if (net_cuts <= minCuts){
    double tot = nodes_on_left+nodes_on_right;
    
    if (nodes_on_left/tot > balanceMin && nodes_on_left/tot < balanceMax){
      val = 1; 
    }
  }
  return val;
}


void newNetwork(int val){
  int createAnother = 0;
  
  do{
   playNetwork = new customNetwork(val);  
   detectNodesPerSide();
   detectCuts();
    
    if (net_cuts <= minCuts)
      createAnother = 1;
    else
      createAnother = 0;

  }while(createAnother == 1);
  
    //playNetwork = new customNetwork(0); 
  //customNetwork saveNetwork = playNetwork;
  //ArrayList<Node> saveNodes = my_nodes;
  //ArrayList<Net> saveNets = my_nets;
  //FM is running into errors, avoid for now!
  //_solve(); //algorithmically generate best solution
  //playNetwork = saveNetwork;
  random_solve();
  //my_nodes = saveNodes;
  //my_nets = saveNets;


}
  