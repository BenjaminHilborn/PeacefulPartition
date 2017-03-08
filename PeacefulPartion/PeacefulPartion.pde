float[] positions =new float [3*2] ;
float CIRCLE_SIZE = 50;
Node[] my_nodes; 


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
 
void setup() 
{
  my_nodes = new Node[5];
  
  for (int i = 0; i<5; i++){
    my_nodes[i] = new Node(random(width),random(height));
  }
  
  
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
  draw_nodes(); // draw nodes
  

}

void draw_nodes(){
    for (int i=0; i < my_nodes.length; i++) {
    if (bover && whichImage==i) 
      stroke(255);  // white
    else
      noStroke(); 
    ellipseMode(CENTER);
    ellipse ( my_nodes[i].x, my_nodes[i].y, CIRCLE_SIZE, CIRCLE_SIZE) ;
  }
}

void node_collision_check(){
  if (locked == false){
    for (int i=0; i < my_nodes.length-1; i++){
      for (int j=i+1; j < my_nodes.length; j++){
       
        
        if (dist(my_nodes[j].x,my_nodes[j].y,my_nodes[i].x,my_nodes[i].y) < CIRCLE_SIZE ){
          float move_dist = 2;
          
          if (my_nodes[i].x > my_nodes[j].x){
            my_nodes[i].x += move_dist;
            my_nodes[j].x -= move_dist;
          }
          else {
            my_nodes[i].x -= move_dist;
            my_nodes[j].x += move_dist;
          }
          
         if (my_nodes[i].y > my_nodes[j].y){
            my_nodes[i].y += move_dist;
            my_nodes[j].y -= move_dist;
          }
          else {
            my_nodes[i].y -= move_dist;
            my_nodes[j].y += move_dist;
          }  
        }      
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
 
  my_nodes[whichImage].x = newx;
  my_nodes[whichImage].y = newy;
}

void checkOver() {
  for (int i=0; i < my_nodes.length; i++) {

    // Test if the cursor is over the node  
    if (dist(mouseX,mouseY,my_nodes[i].x,my_nodes[i].y) < CIRCLE_SIZE/2 )
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
   my_nodes[4].x++; 
}