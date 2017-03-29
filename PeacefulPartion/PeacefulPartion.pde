float[] positions =new float [3*2] ;
float CIRCLE_SIZE = 50; 

// comment
// 0,1,2,3,4,5
// 4,5,6,7,8,9
float bx;
float by;
int bs = 40;
int bz = 30;
boolean bover = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 
float newx, newy;
int whichImage;

customNetwork playNetwork;
ArrayList<Node> my_nodes;
ArrayList<Net> my_nets;

void setup() 
{
  //int num =10;
  //my_nodes = new Node[num];

  //for (int i = 0; i<num; i++){
  //  my_nodes.get(i) = new Node(1,random(width),random(height));
  //
  playNetwork = new customNetwork(0);  

  
  
  imageMode (CENTER);
  size(400, 400); // 960x540 will be final resolution
  bx = width/2.0;
  by = height/2.0;
 
  for (int j=0; j < 3*2; j+=2) {
    positions[j]= random(width-CIRCLE_SIZE);
    positions[j+1]= random(height-CIRCLE_SIZE);
  }
  fill(153);
}
 
void draw() 
{ 
  background(25);
  
  
  node_collision_check(); // checks all nodes to see if they collide with each other
  node_collision_edge();
  draw_nodes(); // draw nodes
  

}

void draw_nodes(){
    for (int i=0; i < my_nodes.size(); i++) {
    if (bover && whichImage==i) 
      stroke(255);  // white
    else
      noStroke(); 
    ellipseMode(CENTER);
    ellipse ( my_nodes.get(i).x, my_nodes.get(i).y, my_nodes.get(i).size, my_nodes.get(i).size) ;
  }
}

void node_collision_check(){
  if (locked == false){
    for (int i=0; i < my_nodes.size()-1; i++){
      for (int j=i+1; j < my_nodes.size(); j++){
       
        // Collisions with other nodes
        if (dist(my_nodes.get(j).x,my_nodes.get(j).y,my_nodes.get(i).x,my_nodes.get(i).y) < (my_nodes.get(i).size + my_nodes.get(j).size)/2 ){
          float move_dist = 2;
          float random = random(6);
          if (random == 5) my_nodes.get(i).x += move_dist;
          if (random == 4) my_nodes.get(j).x -= move_dist;
          
          if (my_nodes.get(i).x > my_nodes.get(j).x){
            my_nodes.get(i).x += move_dist;
            my_nodes.get(j).x -= move_dist;
          }
          else {
            my_nodes.get(i).x -= move_dist;
            my_nodes.get(j).x += move_dist;
          }
          
         if (my_nodes.get(i).y > my_nodes.get(j).y){
            my_nodes.get(i).y += move_dist;
            my_nodes.get(j).y -= move_dist;
          }
          else {
            my_nodes.get(i).y -= move_dist;
            my_nodes.get(j).y += move_dist;
          }  
        }      
      }
    }
  }
}

void node_collision_edge(){
   if (locked == false){
    for (int i=0; i < my_nodes.size(); i++){
       
        // Collisions with   edges      
          float move_dist = 2;
          
          if (my_nodes.get(i).x + my_nodes.get(i).size/2 > width){
            my_nodes.get(i).x -= move_dist;
          }
          else if (my_nodes.get(i).x - my_nodes.get(i).size/2< 0){
            my_nodes.get(i).x += move_dist;
          }          
          if (my_nodes.get(i).y + my_nodes.get(i).size/2> height){
            my_nodes.get(i).y -= move_dist;
          }
          else if (my_nodes.get(i).y - my_nodes.get(i).size/2< 0){
            my_nodes.get(i).y += move_dist;
          } 
        }      
      }
    
}

 
void mousePressed() {
  checkOver();
  if (bover) { 
    locked = true;
  } 
  else {
    locked = false;
  }
}
 
void mouseReleased() {
  locked = false;
  bover = false;
}
 
void mouseDragged() {
  if (locked) {
    newx = mouseX; 
    newy = mouseY;
  }
 
  my_nodes.get(whichImage).x = newx;
  my_nodes.get(whichImage).y = newy;
}

void checkOver() {
  for (int i=0; i < my_nodes.size(); i++) {

    // Test if the cursor is over the node  
    if (dist(mouseX,mouseY,my_nodes.get(i).x,my_nodes.get(i).y) < CIRCLE_SIZE/2 )
    {
      println ("mouseover image: "+i);
      whichImage=i;
      bover = true;  
      break; // leave here !!!!!!!!!!!!!!!!!
    } 
    else
    {
      bover = false;
    }
  }
}

void update() {
   my_nodes.get(4).x++; 
}