//float[] positions =new float [3*2] ;
float CIRCLE_SIZE = 50; 
int totalCurrentCuts;
int newCuts;
//

// comment
// 0,1,2,3,4,5
// 4,5,6,7,8,9
//float bx;
//float by;
//int bs = 40;
//int bz = 30;
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


customNetwork playNetwork;
ArrayList<Node> my_nodes;
ArrayList<Net> my_nets;
ArrayList<Node> gainList;

void setup() 
{
  myFont = createFont("Georgia", 128);
  

  playNetwork = new customNetwork(0);  
  //_solve(); //algorithmically generate best solution
  
  soundSetup();
  
  background(BG_A);
  
  imageMode (CENTER);
  size(960,540); // 960x540 will be final resolution
  //bx = width/2.0;
  //by = height/2.0;
  
  //for (int j=0; j < 3*2; j+=2) {
  //  positions[j]= random(width-CIRCLE_SIZE);
  //  positions[j+1]= random(height-CIRCLE_SIZE);
  //}
  
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
    
  }
  
  if (mode == 2){
    
    draw_partition();
    detectCuts();
    detectNodesPerSide();
    draw_text();
  }

}


void backgroundController(){
  if(locked && BG_A<220) BG_A++;
  if(!locked && BG_A>25) BG_A--;
  background(BG_A);
}
 
void mousePressed() {
  
  if (mode == 0){
    
    // Play
    if (dist(mouseX,mouseY,width/2 - 100, height/2) < CIRCLE_SIZE*2 ){
      mode = 2;
      playNetwork = new customNetwork(0);  
    }
    
    // About
   else if (dist(mouseX,mouseY,width/2 + 100, height/2) < CIRCLE_SIZE*2 ){
      mode = 1;
    }
  }
  
  if (mode == 2){
    
    checkOver();
    if (bover) { 
      locked = true;
    } 
    else {
      locked = false;
      
      if (dist(mouseX,mouseY,50,50) < CIRCLE_SIZE*2 ){
        mode = 0;
    }
    
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
      println ("mouseover image: "+i);
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
     totalCurrentCuts = cuts;
}
  