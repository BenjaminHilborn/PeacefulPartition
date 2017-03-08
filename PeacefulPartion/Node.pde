class Node{
  color c;
  float placedX;
  float placedY;
  float currentX;
  float currentY;
  float randomWalkX;
  float randomWalkY;
  float size;
  float soundFreq;
  
  Node(float tempPlacedX, float tempPlacedY, float tempCurrentX, float tempCurrentY){
  c = color(random(128)+100,random(128)+100,random(128)+100);
  placedX = tempPlacedX;
  placedY = tempPlacedY;
  currentX = tempCurrentX;
  currentY = tempCurrentY;
  randomWalkX=random(10.0);
  randomWalkY=random(10.0);
  size=random(5);
  soundFreq=random(0);
  }
}