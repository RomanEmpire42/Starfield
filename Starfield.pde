int stars = 1000;
int starSpeed = 5;
int centerX, centerY;
Star[] galexy = new Star[stars];
void setup()
{
  size((int)(0.95*window.innerWidth), (int)(0.95*window.innerHeight));
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
  if (centerX > mouseX) {
    centerX -= 1;
  } else {
    centerX += 1;
  }
  if (centerY > mouseY) {
    centerY -= 1;
  } else { 
    centerY += 1;
  }
  //draw
  background(0, 0, 0);
  //test ellipse:
  //ellipse(centerX, centerY, 25, 25);
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

  Star(int x_, int y_) //constructor
  {
    myX = (float)x_;
    myY = (float)y_;
    speed = starSpeed/10.0 * Math.random();
    direction = Math.random()*2*Math.PI;
  }
  void move()
  {
    speed *= 1.05;
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
class Tardis extends Star {
  Tardis() {
    super(centerX, centerY);
    myX -= 5;
    myY -= 5;
    direction = 0.00;
    speed = starSpeed;
  }
  void move() {
    speed = starSpeed;
    boolean loop = true;
    int loops = 0;
    while (loop == true) {
      direction += 0.015;
      if (direction >= 1) {
        direction = 0.00;
      }
      if (dist(myX, myY, (float)centerX, (float)centerY) + 0.1 >= dist((float)(myX + (Math.cos(direction*2*Math.PI))*speed), (float)(myY + ((Math.cos(direction*2*Math.PI))*speed)), (float)centerX, (float)centerY)) {
        loop = false;
        myX += (Math.cos(direction*2*Math.PI))*(speed/2);
        myY += (Math.sin(direction*2*Math.PI))*(speed/2);
      } else {
        if (myX > centerX) {
          myX -= 0.1*speed;
        } else {
          myX += 0.1*speed;
        }
        if (myY > centerY) {
          myY -= 0.1*speed;
        } else { 
          myY += 0.1*speed;
        }
      }
      System.out.println(loops);
      if (loops > 500) {
        if (myX > centerX) {
          myX -= 1;
        } else {
          myX += 1;
        }
        if (myY > centerY) {
          myY -= 1;
        } else { 
          myY += 1;
        }
      }
      if (loops > 1000) {
        break;
      }
      loops++;
    }
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
    text("POLICE TELEPHONE", myX - 29, myY + 12);
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
