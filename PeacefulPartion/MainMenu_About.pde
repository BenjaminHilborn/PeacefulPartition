void draw_mm(){
  
  for (int i = 0; i<5; i++)
  {
    ellipseMode(CENTER);
    fill(my_nodes.get(i).c);
    ellipse(width/2-100+i*48, height/2-190, CIRCLE_SIZE*2, CIRCLE_SIZE*2) ;
  }
  
  // Play  
  stroke(255);
  fill(my_nodes.get(0).c);
  ellipse(width/2 - 100, height/2, CIRCLE_SIZE*2, CIRCLE_SIZE*2);
  
  // About
  fill(my_nodes.get(1).c);
  ellipse(width/2 + 100, height/2, CIRCLE_SIZE*2, CIRCLE_SIZE*2);
  
  textFont(myFont);
  int text_size = 32;
  textSize(text_size);
  fill(255,255,255); //set text to white

  textAlign(CENTER, CENTER);  
  text("Peaceful Partition", width/2, height/2-200);
  
  text_size = 24;
  textSize(text_size);
  text("Play", width/2 - 100, height/2);
  text("About", width/2 + 100, height/2);
  
}