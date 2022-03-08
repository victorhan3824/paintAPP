//sketch-pad rough

//variables
PImage apple;
float sliderY, penWeight;
color penColor, stampFill;
int appleOn;

//color pallette
color white      = #FFFFFF; //background, erase, tactile
color red        = #FF0000;
color pink       = #FF6ABC;
color purple     = #660490;
color brown      = #9F642C;
color blue       = #324BE3;
color lightBlue  = #32A9E3;
color lightGreen = #32E371;
color medGreen   = #006C27;
color yellow     = #F6FF05;
color orange     = #FF7E05;
color darkBrown  = #341F18; // not draw-able
color black      = #000000; // maybe draw-able

void setup() { //========================================
  size(800, 600);
  background(255);
  penColor = red;
  sliderY = 220;
  penWeight = 0;
  apple = loadImage("apple.png");
  appleOn = 1;
  stampFill = color(200);
}

void draw() { //==========================================
  toolBar();
  //color buttons ========================================  
  colorSelectors();
  selectBlack();
  //color indicator ======================================
  stroke(darkBrown);
  fill(penColor);
  rect(100, 20, 10, 160);
  //slider that adjust the stroke weight =================
  strokeAdjust(sliderY);
  //stamp tool ===========================================
  stamp(stampFill);
  //planned switch page button
  fill(white);
  stroke(darkBrown);
  rect(20,345,70,25);
}

void mouseDragged() { //=================================
  if (mouseX > 110 || mouseY > 600) { // drawings
    if (appleOn > 0) {
      stroke(penColor);
      strokeWeight(penWeight);
      line(pmouseX, pmouseY, mouseX, mouseY);
    } else {
      image(apple, mouseX-40, mouseY-40, 80, 80);
    }
  } //end of drawing mode ===============================
  
  sliderControl(); //slider control
}

void mouseReleased() {
  // detect the selected color =================================================================
  colorButtonCheck();
  // end of color detection ====================================================================
  sliderControl(); // slider control
  //stamp control ==============================================================================
  if (mouseX > 15 && mouseX < 95 && mouseY > 380 && mouseY < 460) {
    appleOn = appleOn*-1;
    if (appleOn > 0) stampFill = color(200);
    else stampFill = yellow;
  }
}

//CUSTOM FUNCTIONS begins here =================================================================

void colorSelectors () {
  colorButton(5, 10, red);
  colorButton(45, 10, pink);
  colorButton(5, 50, purple);
  colorButton(45, 50, brown);
  colorButton(5, 90, blue);
  colorButton(45, 90, lightBlue);
  colorButton(5, 130, lightGreen);
  colorButton(45, 130, medGreen);
  colorButton(5, 170, yellow);
  colorButton(45, 170, orange);
}

void toolBar() {
  fill(70);
  stroke(70);
  strokeWeight(2);
  rect(0, 0, 110, 600);
  noFill();
  stroke(150);
  rect(110, 0, 690, 600);
}

void colorButton(int x, int y, color Color) {
  strokeWeight(2);
  fill(Color); //button's indicated color
  if (mouseX > x && mouseX < x+30 && mouseY > y && mouseY < y+30) { //tacile
    stroke(white);
  } else {
    stroke(darkBrown);
  }
  square(x, y, 30);
}

void colorButtonCheck() {
  if (mouseX > 5 && mouseX < 35 && mouseY > 10 && mouseY < 40) penColor = red;
  if (mouseX > 45 && mouseX < 75 && mouseY > 10 && mouseY < 40) penColor = pink; // 1st row
  if (mouseX > 5 && mouseX < 35 && mouseY > 50 && mouseY < 80) penColor = purple;
  if (mouseX > 45 && mouseX < 75 && mouseY > 50 && mouseY < 80) penColor = brown; // 2nd row
  if (mouseX > 5 && mouseX < 35 && mouseY > 90 && mouseY < 120) penColor = blue;
  if (mouseX > 45 && mouseX < 75 && mouseY > 90 && mouseY < 120) penColor = lightBlue; // 3rd row
  if (mouseX > 5 && mouseX < 35 && mouseY > 130 && mouseY < 150) penColor = lightGreen;
  if (mouseX > 45 && mouseX < 75 && mouseY > 130 && mouseY < 150) penColor = medGreen; // 4th row
  if (mouseX > 5 && mouseX < 35 && mouseY > 170 && mouseY < 200) penColor = yellow;
  if (mouseX > 45 && mouseX < 75 && mouseY > 170 && mouseY < 200) penColor = orange; //5th row
  if (dist(mouseX, mouseY, 80, 250) < 15) penColor = black; //selecting black  
}

void selectBlack () {
  fill(black);
  strokeWeight(2);
  if (dist(mouseX, mouseY, 80, 250) < 15) {
    stroke(white);
  } else {
    stroke(darkBrown);
  }
  circle(80, 250, 30);
}

void strokeAdjust(float y) {
  fill(175);
  circle(80, 295, 30);
  fill(penColor);
  if (mouseY > 220 && mouseY < 320 && mouseX > 32 && mouseX < 48) { //slider tactile
    stroke(white);
  } else {
    stroke(175);
  }
  strokeWeight(3);
  line(40, 220, 40, 320);
  circle(40, y, 16);
  noStroke(); //indicator circle
  circle(80, 295, penWeight);
}

void sliderControl() {
  if (mouseY > 220 && mouseY < 320 && mouseX > 32 && mouseX < 48) sliderY = mouseY;
  penWeight = map(sliderY, 220, 320, 1, 20);
}

void stamp(color mode) {
  if (mouseX > 15 && mouseX < 95 && mouseY > 380 && mouseY < 460) stroke(white); //tactile
  else stroke(darkBrown);

  fill(mode);
  rect(15, 380, 80, 80);
  image(apple, 15, 380, 80, 80);
}
