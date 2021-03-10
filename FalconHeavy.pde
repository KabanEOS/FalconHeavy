Star[] stars = new Star[2000];
float speed, speedCraft, Xpos, Ypos,Xvel,Yvel, gravity, hardLandingTolerance;
boolean R, L, U, END;
float tl = 0, tn, tlap;

// MADE BY MICHAŁ MADEJSKI
// 01.04.2020

void setup() {
  
  hardLandingTolerance = 4;
  Xvel = Yvel = 2;
  gravity = 2;
  
  size(1920, 1080);
  Xpos = random(width*0.1, width*0.9);
  Ypos = random(height*0.1, height*0.25);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
   R = L = U = false;

}
void updateTime() {
    tl = tn;
    tn = millis();
    tlap = tn - tl;
}

void draw() {
  background(0);
  //speed = map(mouseX, 0, width, 0, 50);
  speed = 20;
  updateTime();
  drawShip();
  drawBase();
  drawStars();
  fly();
  
}
void drawStars(){
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}

void drawShip(){
    noStroke();
    //head    
    fill(255,255,255);
    rect(Xpos+45,Ypos-30,30,30);
    //body
    fill(167,167,167);
    rect(Xpos,Ypos,120,60);
    //ass
    fill(119,119,119);
    rect(Xpos+45,Ypos+55,30,20);
    //fire
    if(U){
        fill(255,0,0);
        triangle(Xpos+45, Ypos+80, Xpos+75, Ypos+80, Xpos+60, Ypos+150);
        //fill(232,141,24);
        //triangle(Xpos+45, Ypos+80, Xpos+75, Ypos+80, Xpos+60, Ypos+170);
    }
    strokeWeight(6);
    stroke(255,255,255);
    line(Xpos+3,Ypos+60,Xpos+3, Ypos+120);
    line(Xpos+117,Ypos+60,Xpos+117, Ypos+120);
    line(Xpos-10,Ypos+120,Xpos, Ypos+120);
    line(Xpos+120,Ypos+120,Xpos+130, Ypos+120);
   
}

void drawBase(){
    noStroke();
    fill(255,255,255);
    rect(0,height-height*0.07,width, height*0.07);
    noStroke();
    fill(255,0,0);
    rect(width*0.45,height-height*0.07,width*0.1, height*0.07);
}

void fly() {
  
  if(Ypos < height-height*0.07-120){
    Ypos += gravity;
  }
  if(U & Ypos < height-height*0.07-126){
        Yvel -= tlap/7;
  }
  if(L & Ypos < height-height*0.07-126){
        Xvel -= tlap/4;
  }
  if(R & Ypos < height-height*0.07-126){
        Xvel += tlap/4;
  }
  
  Yvel += gravity * tlap/100;
  Xpos += Xvel * tlap/1000;
  Ypos += Yvel * tlap/1000;
  
  if(Ypos > height-height*0.07-126 & Xpos-10 > width*0.45 & Xpos+130 < width*0.55 & Yvel < hardLandingTolerance) {
    Xpos = random(width*0.1, width*0.9);
    Ypos = random(height*0.1, height*0.25);
    delay(1000);
    println("OK");
  }
  if(mousePressed){
    Xpos = random(width*0.1, width*0.9);
    Ypos = random(height*0.1, height*0.25);
    Xvel = Yvel = 2;
    println("RESET");
  }
  if(Ypos > height-height*0.07-126 || Ypos > height-height*0.07-126 & Xpos-10 < width*0.45 || Ypos > height-height*0.07-126 & Xpos+130 > width*0.55 || Xpos > 0.99 * width || Xpos-10 < 0.001 * width || Ypos < 0 ) {
    Xpos = random(width*0.1, width*0.9);
    Ypos = random(height*0.1, height*0.25);
    Xvel = Yvel = 2;
    delay(3000);
    println("BOOM");
  }
}

void keyPressed(){
  if (key==CODED){
    switch (keyCode){
      case UP:
        U = true;
        break;
      case LEFT:
        L = true;
        break;
      case RIGHT:
        R = true;
        break;          
    }
  }  
}
 
void keyReleased(){
  if (key==CODED){
    switch (keyCode){
      case UP:
        U = false;
        break;
      case LEFT:
        L = false;
        break;
      case RIGHT:
        R = false;
        break;    
    }
  }  
}

//stars are from original processing tutorial 
//dont you dare say I've copied, it's 7 AM and I'm doing it since 8PM yesterday, enjoy my magnificient game ;) 
