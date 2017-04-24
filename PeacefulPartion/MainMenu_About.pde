void draw_mm(){
  //draw_mm_rect();
  draw_title();

  
  // Play  
  //fill(255,255,255,155);  ellipse(width/2 + 100, height/2, CIRCLE_SIZE*2+10, CIRCLE_SIZE*2+10);
  //fill(255,255,255,155);  ellipse(width/2 - 100, height/2, CIRCLE_SIZE*2+10, CIRCLE_SIZE*2+10);
  stroke(255);
  fill(my_nodes.get(0).c);  ellipse(width/2 - 100, height/2, CIRCLE_SIZE*2, CIRCLE_SIZE*2);
  
  // About
  fill(my_nodes.get(1).c);  ellipse(width/2 + 100, height/2, CIRCLE_SIZE*2, CIRCLE_SIZE*2);
  
  textFont(myFont);
  //int text_size = 32;
  //textSize(text_size);
  fill(0,0,0); //set text to white

  textAlign(CENTER, CENTER);  
  //text("Peaceful Partition", width/2, height/2-200);
  
  textSize(24);
  text("Play", width/2 - 100+1, height/2+1);
  text("About", width/2 + 100+1, height/2+1);
  
  fill(255,255,255);
  text("Play", width/2 - 100, height/2);
  text("About", width/2 + 100, height/2);
  
}

void draw_title(){
  rectMode(CENTER);
  fill(0,0,0,155);
  rect(width/2,height/2,width,height);
  
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
  text("Peaceful Partition", width/2+1, height/2-200+1);
  fill(255,255,255);           text("Peaceful Partition", width/2, height/2-200);
  
}

void draw_mm_rect(){
  stroke(255);
  rectMode(CENTER);
  int filly=12;
  fill(filly,filly,filly,155);
  rect(width/2,height/2+50,width-600,height-400);
}

void draw_about(){
  stroke(255);
  rectMode(CENTER);
  int filly=12;
  fill(filly,filly,filly,222);
  rect(width/2,height/2+50,width-200,height-250);
}

void draw_about_text(){
  textFont(myFont);
  textSize(16);
  fill(255,255,255);
  textAlign(CENTER, CENTER);  
  String mytext = "Programming and Design By: \n Ben Hilborn\n Justin Hrischuk\n Sounak Biswas\n\n"+
  "Algorithms Used: Fiduccia-Mattheyses for Partitioning \n\n ENCM 507, 2017";
  text(mytext,width/2,height/2+50);
}