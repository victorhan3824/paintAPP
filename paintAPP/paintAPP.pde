//SKETCH PAD ==========================================

//variables
PImage apple, paintBucket, pen;
float sliderY, penWeight;
color penColor, stampStatus, eraseColor;
int appleOn, pageNum, penOn;

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
color black      = #000000;

void setup() { //========================================
  size(800, 600);
  background(255);
  textAlign(CENTER, CENTER);
  penColor = red;
  sliderY = 220;
  penWeight = 0;
  apple = loadImage("apple.png");
  paintBucket = loadImage("paint.png");
  pen = loadImage("pen.png");
  appleOn = 1;
  stampStatus = color(200);
  pageNum = 1;
  penOn = -1;
  eraseColor = white;
}

void draw() { //==========================================
  toolBar();
  //color buttons ========================================
  colorSelectors();
  selectBlack();
  //color indicator ======================================
  stroke(darkBrown);
  fill(penColor);
  rect(100, 20, 8, 160);
  //slider that adjust the stroke weight =================
  strokeAdjust(sliderY);

  //page Switcher ========================================
  pageSwitcher();
  //stamp indicator ======================================
  if (appleOn > 0) stampStatus = color(200); 
  else stampStatus = yellow;
  stroke(darkBrown);
  fill(stampStatus);
  rect(100, 380, 8, 70);
  //penOn indicator
  if (penOn < 0) fill(yellow);
  if (penOn > 0) fill(200);
  stroke(darkBrown);
  rect(100, 460, 8, 70);

  if (pageNum == 1) { //page number 1
    //stamp tool =========================================
    stamp();
    // 3 buttons clear, save, load
    clearButton();
    saveButton();
    loadButton();
  }
  if (pageNum == -1) { //pageNumber 2
    eraser();
    paintBrush();
    penIndicator();
  }
  
  //line that indicates the selected color
  stroke(penColor);
  strokeWeight(3);
  line(111,0,111,600);
}

void mouseDragged() { //=================================
  if (penOn == -1) {
    if (mouseX > 110 || mouseY > 600) { // drawings
      if (appleOn > 0) {
        stroke(penColor);
        strokeWeight(penWeight);
        line(pmouseX, pmouseY, mouseX, mouseY);
      } else {
        image(apple, mouseX-(80+5*penWeight)/2, mouseY-(80+5*penWeight)/2, 80+5*penWeight, 80+5*penWeight);
      }
    } //end of drawing mode =============================
  }
  sliderControl(); //slider control
}

void mouseReleased() {
  // detect the selected color =================================================================
  colorButtonCheck();
  // end of color detection ====================================================================
  sliderControl(); // slider control

  //page switcher
  if (mouseX > 30 && mouseX < 90 && mouseY > 345 && mouseY < 370) pageNum = pageNum*-1;

  if (pageNum == 1) { //Page number 1
    //stamp control =============================================================================
    if (mouseX > 15 && mouseX < 95 && mouseY > 380 && mouseY < 460) appleOn = appleOn*-1;
    //clear everything ==========================================================================
    if (mouseX > 30 && mouseX < 90 && mouseY > 470 && mouseY < 495) {
      noStroke();
      fill(white);
      rect(113, 0, 790, 600);
    }
    //save images ================================================================================
    if (mouseX > 30 && mouseX < 90 && mouseY > 505 && mouseY < 530) selectOutput("Choose a name for your image", "saveImage");
    //load images ================================================================================
    if (mouseX > 30 && mouseX < 90 && mouseY > 540 && mouseY < 565) selectInput("Pick a file to load", "getImage");
  } //end ========================================================================================
  if (pageNum == -1) {
    //pen status
    if (mouseX > 20 && mouseX < 90 && mouseY > 460 && mouseY < 530) penOn = penOn*-1;
    //paint bucket
    if (mouseX > 20 && mouseX < 90 && mouseY > 380 && mouseY < 450) {
      noStroke();
      fill(penColor);
      eraseColor = penColor;
      rect(113, 0, 790, 600);
    }
    //eraser =====================================================================================
    if (mouseX > 30 && mouseX < 90 && mouseY > 540 && mouseY < 565) {
      penColor = eraseColor;
      appleOn = 1;
    }
  }
}

//CUSTOM FUNCTIONS begins here ===================================================================

void saveImage(File f) {
  if (f != null) {
    PImage canvas = get(110, 0, width-110, height); //forms a rectangle, size(width,height, ...)
    canvas.save(f.getAbsolutePath());
  }
}

void getImage(File f) {
  if (f != null) {
    //KLUDGE
    int n = 0;
    while (n < 10) {
      PImage pic = loadImage(f.getPath());
      image(pic, 110, 0, 690, 600);
      n = n + 1;
    }
  }
}

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
  stroke(50);
  strokeWeight(2);
  rect(0, 0, 110, 600);
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
  checkButton(5, 10, 30, 30, red);
  checkButton(45, 10, 30, 30, pink);
  checkButton(5, 50, 30, 30, purple);
  checkButton(45, 50, 30, 30, brown);
  checkButton(5, 90, 30, 30, blue);
  checkButton(45, 90, 30, 30, lightBlue);
  checkButton(5, 130, 30, 30, lightGreen);
  checkButton(45, 130, 30, 30, medGreen);
  checkButton(5, 170, 30, 30, yellow);
  checkButton(45, 170, 30, 30, orange);
  if (dist(mouseX, mouseY, 80, 250) < 15) { //black =============
    penColor = black;
    appleOn = 1;
  }
}

void checkButton(int x, int y, int w, int h, color c) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    penColor = c;
    appleOn = 1;
  }
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

void stamp() {
  if (mouseX > 15 && mouseX < 95 && mouseY > 380 && mouseY < 460) stroke(white); //tactile
  else stroke(darkBrown);

  fill(200);
  rect(15, 380, 80, 80);
  image(apple, 15, 380, 80, 80);
}

void pageSwitcher() {
  fill(0);
  if (mouseX > 20 && mouseX < 90 && mouseY > 345 && mouseY < 370) stroke(white);
  else stroke(darkBrown);
  rect(20, 345, 70, 25);
  fill(255);
  if (pageNum == 1) text("PAGE 1", 55, 358);
  if (pageNum == -1) text("PAGE 2", 55, 358);
}

void clearButton() {
  fill(0);
  if (mouseX > 20 && mouseX < 90 && mouseY > 470 && mouseY < 495) stroke(white);
  else stroke(darkBrown);
  rect(20, 470, 70, 25);
  fill(255);
  text("CLEAR", 55, 483);
}

void saveButton() {
  fill(0);
  if (mouseX > 20 && mouseX < 90 && mouseY > 505 && mouseY < 530) stroke(white);
  else stroke(darkBrown);
  rect(20, 505, 70, 25);
  fill(255);
  text("SAVE", 55, 518);
}

void loadButton() {
  fill(0);
  if (mouseX > 20 && mouseX < 90 && mouseY > 540 && mouseY < 565) stroke(white);
  else stroke(darkBrown);
  rect(20, 540, 70, 25);
  fill(255);
  text("LOAD", 55, 553);
}

void eraser() {
  fill(0);
  if (mouseX > 20 && mouseX < 90 && mouseY > 540 && mouseY < 565) stroke(white);
  else stroke(darkBrown);
  rect(20, 540, 70, 25);
  fill(255);
  text("ERASE", 55, 553);
}

void paintBrush () {
  if (mouseX > 20 && mouseX < 90 && mouseY > 380 && mouseY < 450) stroke(white); //tactile
  else stroke(darkBrown);
  fill(200);
  rect(20, 380, 70, 70);
  image(paintBucket, 20, 380, 70, 70);
}

void penIndicator () {
  if (mouseX > 20 && mouseX < 90 && mouseY > 460 && mouseY < 530) stroke(white); //tactile
  else stroke(darkBrown);
  fill(200);
  rect(20, 460, 70, 70);
  image(pen,20,460,70,70);
}
