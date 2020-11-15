int stars = 1000;
int starSpeed = 5;
float centerX, centerY;
Star[] galexy = new Star[stars];
void setup()
{
  size((int)(0.85*window.innerWidth), (int)(0.75*window.innerHeight));
  centerX = width/2;
  centerY = height/2;
  for (int i = 0; i < stars; i++) {
    if (i == (stars - 1)) {
      galexy[i] = new Tardis();
    } else {
      galexy[i] = new Star(centerX, centerY);
    }
  }
}
void draw()
{
  //move center
    double angleToCenter = Math.atan2((double)mouseY-centerY, (double)mouseX-centerX);
    centerX += (Math.cos(angleToCenter));
    centerY += (Math.sin(angleToCenter));
  //draw
  background(0, 0, 0);
  fill(0, 0, 0);
  for (int i=0; i<galexy.length; i++) {
    if (Math.abs(galexy[i].myX-width/2)>width || Math.abs(galexy[i].myY-height/2)>height) {
      galexy[i] = new Star(centerX, centerY);
    }
    galexy[i].move();
    galexy[i].show();
  }
  fill(255);
  textSize(20);
  text(starSpeed + " Speed", width/2 - 40, 0.9*height);
}
void mousePressed()
{
  setup();
}
void keyPressed() {
  if (keyCode==UP) {
    starSpeed+= 1;
    //starSpeed = round(starSpeed*10)/10;
  }
  if (keyCode==DOWN&&starSpeed>=1) {
    starSpeed-= 1;
  }
}
class Star
{
  float myX, myY;
  double direction;
  double speed;
  float size = 10;
  int myColor = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
  float beta = 0;

  Star(float x_, float y_) //constructor
  {
    myX = x_;
    myY = y_;
    speed = starSpeed/10.0 * Math.random();
    direction = Math.random()*2*Math.PI;
  }
  void move()
  {
    speed *= 1.05;
    direction += 0.005*2*Math.PI;
    myX += ((float)Math.cos(direction))*speed;
    myY += ((float)Math.sin(direction))*speed;
  }
  void show()
  {
    beta = dist(myX, myY, (float)centerX, (float)centerY);
    fill(myColor, beta);
    ellipse(myX, myY, (float)(size*(beta/width)*speed/10), (float)(size*(beta/width)*speed/10));
  }
}


//---------------------------------
//---------------------------------


class Tardis extends Star {
  float dirX = 0;
  float dirY = 0;
  Tardis() {
    super(centerX, centerY);
    myX -= 5;
    myY -= 5;
    direction = 0.00;
    speed = starSpeed;
    dirX = 1;
    dirY = 0;
  }
  void move() {
    //test:
    fill(255);
    strokeWeight(5);
    stroke(55);
    //ellipse(centerX, centerY, 25, 25);
    //line(myX, myY, myX+dirX*500, myY+dirY*500);
    strokeWeight(1);
    stroke(0);
    
    speed = starSpeed;
    int orbitDistance = 50;
    double centerDirection = Math.atan2((double)centerY-myY, (double)centerX-myX);
    dirX += Math.cos(centerDirection)/orbitDistance;
    dirY += Math.sin(centerDirection)/orbitDistance; 
    myX += dirX*(speed);
    myY += dirY*(speed);
  }
  void show() {
      //Box Structure
    fill(0, 0, 100);
    rect(myX - 50, myY - 70, 100, 150);
    rect(myX - 45, myY - 80, 90, 10);
    rect(myX - 53, myY + 80, 106, 10);
    //Box Panels
    rect(myX + 7, myY + 5, 30, 28);
    rect(myX + 7, myY + 38, 30, 28);
    rect(myX - 37, myY + 5, 30, 28);
    rect(myX - 37, myY + 38, 30, 28);
      //Police Box Logo
    fill(0);
    rect(myX - 40, myY - 65, 80, 15);
    fill(255);
    textSize(9);
    text("POLICE        BOX", myX - 35, myY - 54);
    textSize(5);
    text("PUBLIC", myX - 1, myY - 58);
    text("CALL", myX + 1, myY - 52);
      //Left Window 
    //Top
    rect(myX - 37, myY - 40, 10, 20);
    rect(myX - 27, myY - 40, 10, 20);
    rect(myX - 17, myY - 40, 10, 20);
    //Bottom
    rect(myX - 37, myY - 20, 10, 20);
    rect(myX - 27, myY - 20, 10, 20);
    rect(myX - 17, myY - 20, 10, 20);
      //Right Window
    //Top
    rect(myX + 7, myY - 40, 10, 20);
    rect(myX + 17, myY - 40, 10, 20);
    rect(myX + 27, myY - 40, 10, 20);
    //Bottom
    rect(myX + 7, myY - 20, 10, 20);
    rect(myX + 17, myY - 20, 10, 20);
    rect(myX + 27, myY - 20, 10, 20);
      //Light
    rect(myX - 3, myY - 90, 6, 10);
      //Police Note Thing
    rect(myX - 32, myY + 6, 20, 25);
    fill(0);
    textSize(2);  
    text("POLICE TELEPHONE", myX - 31.5, myY + 11);
    text("FREE", myX - 24, myY + 14);
    text("FOR USE OF", myX - 27, myY + 16);
    text("PUBLIC", myX - 25, myY + 18);
    textSize(1);
    text("ADVICE & ASSISTANCE", myX - 27, myY + 20);
    text("OBTAINABLE IMMEDIATELY", myX - 28, myY + 22);
    text("OFFICERS & CARS", myX - 26, myY + 24);
    text("RESPOND TO ALL CALLS", myX - 28, myY + 26);
    textSize(2);
    text("PULL TO OPEN", myX - 28, myY + 28);
  }
}
