float[] positions =new float [3*2] ;
float CIRCLE_SIZE = 50;

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
 
  for (int j=0; j < 3; j++) {
    if (bover && whichImage==j) 
      stroke(255);  // white
    else
      noStroke(); 
    ellipseMode(CENTER);
    ellipse ( positions[j*2], positions[j*2+1], CIRCLE_SIZE, CIRCLE_SIZE) ;
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
 
  positions [whichImage*2] = newx;
  positions [(whichImage*2)+1] = newy;
}

void checkOver() {
  for (int i=0; i < 3; i++) {

    // Test if the cursor is over the node  
    if (dist(mouseX,mouseY,positions[i*2],positions[i*2+1]) < CIRCLE_SIZE/2 )
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
  } // for
}