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
    soundFreq=C_Scale[int(random(1,7))];
    gain=0;
  }
  
  
  IntList m_netIds = new IntList();
  
  int getDegree() { return m_netIds.size(); }
  int gain;
  
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

void detectNodesPerSide(){
  int left = 0;
  int right = 0;
  
  for (int i=0; i < my_nodes.size(); i++){
    if (my_nodes.get(i).x > window_width/2) right++;
    else  left++;
  }
  
  nodes_on_right = right;
  nodes_on_left = left;
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
          float x = my_nodes.get(i).x;
          float y = my_nodes.get(i).y;
          float size = my_nodes.get(i).size;
          
          // Right & left sides
          if (x + size/2 > width-25){
            my_nodes.get(i).x -= move_dist;
          }
          else if (x - size/2< 35){
            my_nodes.get(i).x += move_dist;
          }
          
          // Top and bottom
          if (y + size/2> height-25){
            my_nodes.get(i).y -= move_dist;
          }
          else if (y - size/2< 25){
            my_nodes.get(i).y += move_dist;
          }
          
          // Collision with center
          if (abs(x - width/2)< size/2 + 5){
            if (x > width/2)    my_nodes.get(i).x += move_dist;
            else                my_nodes.get(i).x -= move_dist;
          }
        }
    }     
}

//void (

// Randomly move the nodes
void node_randomize_movement(){
    for (int i=0; i < my_nodes.size(); i++){
       
      float num = round(random(6));
      
      if (num == 1.0){
            my_nodes.get(i).x -= random(-2,2);
           // println("LOL");
      }
      
      if (num == 2.0){
            my_nodes.get(i).y -= random(-2,2);
      }
    }     
}
/*class Node{
  color c;
  float x;
  float y;
  float currentX;
  float currentY;
  float randomWalkX;
  float randomWalkY;
  float size;
  float soundFreq;
  
  Node(float tempPlacedX, float tempPlacedY){
  c = color(random(128)+100,random(128)+100,random(128)+100);
  x = tempPlacedX;
  y = tempPlacedY;
  //currentX = tempCurrentX;
  //currentY = tempCurrentY;
  randomWalkX=random(10.0);
  randomWalkY=random(10.0);
  size=random(5);
  soundFreq=random(0);
  }
  
}*/