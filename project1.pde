// import processing.sound.*;
import ddf.minim.*;
Minim minim;
AudioSample sound;
AudioPlayer bkm;

// SoundFile sound;
// SoundFile bkm;
int startTime;

PImage img;
PImage ball;
PImage bigball;

//Simulation paramaters
static int maxParticles = 3;
int score = 0;
Vec2 spherePos = new Vec2(480,700);
float sphereRadius = 55;
float sphereRadius2 = 30;
float sphereMass = Float.MAX_VALUE;
Circle obstacle = new Circle(spherePos, sphereRadius);
// ParticleSystem ps = new ParticleSystem(new Vec2(445, 600));
// range: 30 - 860

Circle[] ballObstacle = new Circle[]{
  new Circle(new Vec2(483, 95), 50, new Vec2(0, 0)),
  new Circle(new Vec2(331, 145), 45, new Vec2(0, 0)),
  new Circle(new Vec2(635, 145), 45, new Vec2(0, 0)),

  // new Circle(new Vec2(375, 460), 25, new Vec2(0, 0)),
  // new Circle(new Vec2(483, 425), 24, new Vec2(0, 0)),
  new Circle(new Vec2(483, 305), 24, new Vec2(0, 0)),

  new Circle(new Vec2(800, 370), 40, new Vec2(0, 0)),
  new Circle(new Vec2(415+30+100, 370), 25, new Vec2(0, 0)),
  new Circle(new Vec2(415, 370), 25, new Vec2(0, 0)),
  new Circle(new Vec2(165, 370), 40, new Vec2(0, 0)),


  // new Circle(new Vec2(415+30, 650), 55, new Vec2(0, 0)),
  // new Circle(new Vec2(415+30, 250), 15, new Vec2(0, 0)),
  // new Circle(new Vec2(480, 460), 25, new Vec2(0, 0)),
  // new Circle(new Vec2(415+30-100, 300), 15, new Vec2(0, 0)),
  // new Circle(new Vec2(415+30-100, 400), 15, new Vec2(0, 0)),
  };

Circle bigBall = new Circle(new Vec2(484, 550), 90, new Vec2(0, 0));


Line[] lineObstacles = new Line[]{
  new Line(new Vec2(115, 40), new Vec2(115, 839)), 
  new Line(new Vec2(115, 40), new Vec2(847, 40)), 
  new Line(new Vec2(847, 40), new Vec2(847, 437)),
  new Line(new Vec2(930, 540), new Vec2(847, 437)),
  new Line(new Vec2(930, 540), new Vec2(930, 1000)),

  new Line(new Vec2(890, 550), new Vec2(890, 1000)),
  new Line(new Vec2(890, 550),new Vec2(847, 550)),
  new Line(new Vec2(847, 550), new Vec2(847, 839)),
  // new Line(new Vec2(0, 1000), new Vec2(860, 1060)),
  // new Line(new Vec2(860, 1060), new Vec2(960, 1060)),
};

Line[] lineObstacles2 = new Line[]{
  new Line(new Vec2(115, 839), new Vec2(115+338*cos(radians(39.6)), 839+338*sin(radians(39.6)))), 
  new Line(new Vec2(847, 839), new Vec2(847-338*cos(radians(39.6)), 839+338*sin(radians(39.6)))),
  new Line(new Vec2(115+338*cos(radians(39.6)), 839+338*sin(radians(39.6))), new Vec2(847-338*cos(radians(39.6)), 839+338*sin(radians(39.6)))),
  };

Line[] triangleObstacles = new Line[]{
  new Line(new Vec2(253, 610), new Vec2(253, 735)),
  new Line(new Vec2(253, 610), new Vec2(300, 610)),
  new Line(new Vec2(253, 735), new Vec2(335, 795)), 
  new Line(new Vec2(335, 795), new Vec2(365, 775)), 
  new Line(new Vec2(300, 610), new Vec2(365, 775)), 

  new Line(new Vec2(710, 610), new Vec2(710, 735)),
  new Line(new Vec2(710, 610), new Vec2(663, 610)),
  new Line(new Vec2(710, 735), new Vec2(628, 795)),
  new Line(new Vec2(628, 795), new Vec2(597, 775)),
  new Line(new Vec2(663, 610), new Vec2(597, 775)),

  new Line(new Vec2(331, 410),  new Vec2(331-220*cos(radians(39.6)), 410+220*sin(radians(39.6)))),
  new Line(new Vec2(350, 425),  new Vec2(350-220*cos(radians(39.6)), 425+220*sin(radians(39.6)))),
  new Line(new Vec2(630, 410),  new Vec2(630+220*cos(radians(39.6)), 410+220*sin(radians(39.6)))),
  new Line(new Vec2(615, 425),  new Vec2(615+220*cos(radians(39.6)), 425+220*sin(radians(39.6)))),
  new Line(new Vec2(331, 410), new Vec2(350, 425)),
  new Line(new Vec2(630, 410), new Vec2(615, 425)),
  new Line(new Vec2(331-220*cos(radians(39.6)), 410+220*sin(radians(39.6))),  new Vec2(350-220*cos(radians(39.6)), 425+220*sin(radians(39.6)))),
  new Line(new Vec2(630+220*cos(radians(39.6)), 410+220*sin(radians(39.6))), new Vec2(615+220*cos(radians(39.6)), 425+220*sin(radians(39.6)))),

  };

Line[] triangleObstacles2 = new Line[]{
  new Line(new Vec2(160, 630), new Vec2(160, 805)),
  new Line(new Vec2(160, 630), new Vec2(203, 630)),
  new Line(new Vec2(203, 760), new Vec2(203, 630)),
  new Line(new Vec2(203, 760),  new Vec2(203+160*cos(radians(39.6)), 760+160*sin(radians(39.6)))),
  new Line(new Vec2(160, 805), new Vec2(160+160*cos(radians(44)), 805+160*sin(radians(44)))), 
  new Line(new Vec2(440, 985),  new Vec2(203+160*cos(radians(39.6)), 760+160*sin(radians(39.6)))),
  new Line(new Vec2(430, 1000), new Vec2(160+160*cos(radians(44)), 805+160*sin(radians(44)))), 
  new Line(new Vec2(440, 985), new Vec2(430, 1000)),

  new Line(new Vec2(800, 630), new Vec2(800, 805)),
  new Line(new Vec2(800, 630), new Vec2(757, 630)),
  new Line(new Vec2(757, 760), new Vec2(757, 630)),
  new Line(new Vec2(757, 760),  new Vec2(757-160*cos(radians(39.6)), 760+160*sin(radians(39.6)))),
  new Line(new Vec2(800, 805), new Vec2(800-160*cos(radians(44)), 805+160*sin(radians(44)))), 
  new Line(new Vec2(492, 935),  new Vec2(757-160*cos(radians(39.6)), 760+160*sin(radians(39.6)))),
  new Line(new Vec2(495, 950), new Vec2(800-160*cos(radians(44)), 805+160*sin(radians(44)))), 
  new Line(new Vec2(492, 935), new Vec2(495, 950)),
  // new Line(new Vec2(440, 985),  new Vec2(203-160*cos(radians(39.6)), 760+160*sin(radians(39.6)))),
  // new Line(new Vec2(440, 985), new Vec2(160-160*cos(radians(44)), 805+160*sin(radians(44)))), 
  };


Vec2 offset1 = new Vec2(165*cos(radians(20)), 165*sin(radians(20)));
Vec2 offset2 = new Vec2(-165*cos(radians(20)), 165*sin(radians(20)));
// Line[] flippers = new Line[]{
//   new Line(lineObstacles2[0].pt2, lineObstacles2[0].pt2.plus(offset1)),
//   new Line(lineObstacles2[1].pt2, lineObstacles2[1].pt2.plus(offset2))
// };
Line[] flippers = new Line[]{};

Box launcher = new Box(new Vec2(910, 855), 40, 25);

Box[] exitBox = new Box[]{new Box(
  new Vec2(450+30, 860),
  300,
  120)
};



float r = 15;
float m = 10;
float genRate = 20;
float obstacleSpeed = 200;
float COR = 0.75;
Vec2 gravity = new Vec2(0,350);

//Initalalize variable
Circle[] pinballs = new Circle[maxParticles];
Vec2 pos[] = new Vec2[maxParticles];
Vec2 vel[] = new Vec2[maxParticles];
float lifeList[] = new float[maxParticles];
Col colList[] = new Col[maxParticles];
ParticleSystem[] pss = new ParticleSystem[maxParticles];
int numParticles = 0;
float maxLife = 0.01;



void setup(){
  img = loadImage("texture\\Screenshot 2023-09-28 234801.png");
  ball = loadImage("texture\\Screenshot 2023-09-28 234801 - Copy.png");
  bigball = loadImage("texture\\bigball.jpg");
  size(960,1080, P2D);
  img.resize(width, height);

  minim = new Minim(this);
  sound = minim.loadSample("sunflower-street-drumloop-85bpm-163900.mp3", 512);
  bkm = minim.loadFile("8bit-music-for-game-68698.mp3");
  bkm.loop();
  // ball.resize(30, 30);
  // sound = new SoundFile(this, "sunflower-street-drumloop-85bpm-163900.mp3");
  // bkm = new SoundFile(this, "8bit-music-for-game-68698.mp3");
  surface.setTitle("Pinball simulation");
  strokeWeight(2); //Draw thicker lines 
}

// range: 30 - 860
Vec2 obstacleVel = new Vec2(0,0);

void update(float dt){
  obstacle.mass = sphereMass;

  float toGen_float = genRate * dt;
  int toGen = int(toGen_float);
  float fractPart = toGen_float - toGen;
  if (random(1) < fractPart) toGen += 1;
  for (int i = 0; i < toGen; i++){
    if (numParticles >= maxParticles) break;
    // pos[numParticles] = new Vec2(20+random(600),random(20));
    // vel[numParticles] = new Vec2(0,-10000+random(10));
    lifeList[numParticles] = 0;
    colList[numParticles] = new Col(255, 0, 0);
    pss[numParticles] = new ParticleSystem(new Vec2(445, 600));
    //vel[numParticles] = new Vec2(60,-200); 

    Vec2 temp_vel = new Vec2(0,0);
    pinballs[numParticles] = new Circle(new Vec2(905.5,780-numParticles*r*2), r-2);
    pinballs[numParticles].vel = temp_vel;
    pinballs[numParticles].mass = m;
    numParticles += 1;
  }
  

  obstacleVel = new Vec2(0,0);
  if (leftPressed) obstacleVel = obstacleVel.plus(new Vec2(-obstacleSpeed,0));
  if (rightPressed) obstacleVel = obstacleVel.plus(new Vec2(obstacleSpeed,0));
  if (upPressed) obstacleVel = obstacleVel.plus(new Vec2(0,-obstacleSpeed));
  if (downPressed) obstacleVel = obstacleVel.plus(new Vec2(0,obstacleSpeed));
  if (upPressed) launch();
  obstacleVel.clampToLength(obstacleSpeed);
  if (shiftPressed) obstacleVel = obstacleVel.times(2);
  obstacle.vel = obstacleVel;
  obstacle.center.add(obstacleVel.times(dt));
  
  for (int i = 0; i <  numParticles; i++){
    Vec2 acc = gravity; //Gravity
    lifeList[i] += dt;
    // colList[i].g = lifeList[i]/maxLife;

    pinballs[i].vel.add(acc.times(dt));
    pinballs[i].center.add(pinballs[i].vel.times(dt)); 

    if (pinballs[i].center.y > height - r){
      pinballs[i].center.y = height - r;
      pinballs[i].vel.y *= -COR;
    }
    if (pinballs[i].center.y < r){
      pinballs[i].center.y = r;
      pinballs[i].vel.y *= -COR;
    }
    if (pinballs[i].center.x > width - r){
      pinballs[i].center.x = width - r;
      pinballs[i].vel.x *= -0.2;
    }
    if (pinballs[i].center.x < r){
      pinballs[i].center.x = r;
      pinballs[i].vel.x *= -0.2;
      pinballs[i].vel.x = 0;
    }
    
    pinballCollision(pinballs);
    obstacleCollision(pinballs);
  }
}

void pinballCollision(Circle[] pinballs){
  int length = min(pinballs.length, numParticles);
  for(int i = 0; i < length-1; i++){
    for(int j = i+1; j < length; j++){
      if (colliding(pinballs[i], pinballs[j])){
        collisionResponseStatic(pinballs[i], pinballs[j], 0.65, true);
      }
    }
  }
}

void collisionResponseStatic(Circle ball1, Circle ball2, float cor, boolean elastic){
  if (elastic){
    Vec2 dir = (ball2.center.minus(ball1.center));
    float dist = dir.length();
    if (dist > ball1.radius+ball2.radius) return;
    dir = dir.normalized();

    float overlap = (ball1.radius + ball2.radius - dist) /2;
    ball1.center.subtract((dir.times(overlap)).times(1.01));
    ball2.center.add((dir.times(overlap)).times(1.01));


    float v1 = dot(ball1.vel, dir);
    float v2 = dot(ball2.vel, dir);

    float m1 = ball1.mass;
    float m2 = ball2.mass;

    float new_v1 = (m1 * v1 + m2 * v2 - m2 * (v1 - v2) * cor) / (m1 + m2);
    float new_v2 = (m1 * v1 + m2 * v2 - m1 * (v2 - v1) * cor) / (m1 + m2);

    ball1.vel.add(dir.times(new_v1 - v1));
    ball2.vel.add(dir.times(new_v2 - v2));
  }
  else{
    Vec2 normal = (ball1.center.minus(ball2.center)).normalized();
    ball1.center = ball2.center.plus(normal.times(ball2.radius+ball1.radius).times(1.01));
    Vec2 velNormal = normal.times(dot(ball1.vel,normal));
    ball1.vel.subtract(velNormal.times(1 + cor));
  }
  // ball1.center.add(ball1.vel.times(dt)); 
  // ball2.center.add(ball2.vel.times(dt));
}

void collisionResponseStatic(Circle ball, Line line, float cor){
  // ball.center.subtract(ball.vel.times(dt)); 
  Vec2 v1 = ball.center.minus(line.pt1);
  Vec2 v2 = line.pt2.minus(line.pt1);
  float proj = dot(v2, v1) / v2.length();
  Vec2 closest = line.pt1.plus(v2.normalized().times(proj));
  // ball.center = closest;
  Vec2 dist = ball.center.minus(closest);
  // println("closest:", closest.x, closest.y);
  // println("center:", ball.center.x, ball.center.y);
  // if (dist.length() < ball.radius){

    // ball.center.add(dist.normalized().times((abs(ball.radius-dist.length())+5)*1.01));
  Vec2 normal = new Vec2(-v2.y, v2.x).normalized();
  // if (dot(normal, v2) != 0) println("error"); 

  float d = dot(normal, dist);
  if (d < 0){
    normal.mul(-1);
  }

  ball.center = closest.plus(normal.times(ball.radius));
  Vec2 velNormal = normal.times(dot(ball.vel,normal));
  ball.vel.subtract(velNormal.times(1 + cor));
}



void obstacleCollision(Circle[] pinballs){
  int length = min(pinballs.length, numParticles);
  for(int i = 0; i < length; i++){
    if (colliding(pinballs[i], bigBall)){
      collisionResponseStatic(pinballs[i], bigBall, COR, false);
      score+=100;
      sound.trigger();
      startTime = millis();
    }
    for(int j = 0; j <ballObstacle.length; j++){
      if (colliding(pinballs[i], ballObstacle[j])){
        collisionResponseStatic(pinballs[i], ballObstacle[j], COR, false);
        score+=100;
          sound.trigger();
        startTime = millis();
      }
    }
    if (millis() - startTime >= 300) {
      sound.stop();
    }
    for(int j = 0; j <lineObstacles.length; j++){
      //Line path = new Line(pinballs[i].center, pinballs[i].center.miuns(pinballs[i].vel.times(dt)));
      //if (colliding(path, lineObstacles[j])){
       if (colliding(lineObstacles[j], pinballs[i])){
      collisionResponseStatic(pinballs[i], lineObstacles[j], COR);
      }
    }
    for(int j = 0; j <lineObstacles2.length; j++){
      if (colliding(lineObstacles2[j], pinballs[i])){
      collisionResponseStatic(pinballs[i], lineObstacles2[j], COR);
      }
    }
    for(int j = 0; j <flippers.length; j++){
      if (colliding(flippers[j], pinballs[i])){
      collisionResponseStatic(pinballs[i], flippers[j], COR);
      score+=100;
      }
    }
    for(int j = 0; j <triangleObstacles.length; j++){
      if (colliding(triangleObstacles[j], pinballs[i])){
        collisionResponseStatic(pinballs[i], triangleObstacles[j], COR);
          sound.trigger();
          startTime = millis();
        score+=100;
      }
    }
    
    for(int j = 0; j <triangleObstacles2.length; j++){
      if (colliding(triangleObstacles2[j], pinballs[i])){
        collisionResponseStatic(pinballs[i], triangleObstacles2[j], COR);
      }
    }
    if (millis() - startTime >= 300) {
      sound.stop();
    }
    for(int j = 0; j <exitBox.length; j++){
      if (colliding(pinballs[i], exitBox[j])){
        pss[i] = new ParticleSystem(pinballs[i].center);
        pss[i].addParticle();
      }else{
        pss[i].clear();
      }
    }

    if (colliding(pinballs[i], launcher)){
      collisionResponseStatic(pinballs[i], launcher.bottom(), 0.7);
    }
  }

}


boolean leftPressed, rightPressed, upPressed, downPressed, shiftPressed;
void keyPressed(){
  if (keyCode == LEFT) leftPressed = true;
  if (keyCode == RIGHT) rightPressed = true;
  if (keyCode == UP) launch(); 
  if (keyCode == DOWN) downPressed = true;
  if (keyCode == SHIFT) shiftPressed = true;
  if (key == ' ') paused = !paused;
}

void keyReleased(){
  if (key == 'r'){
    println("Reseting the System");
    numParticles = 0;
  }
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
  if (keyCode == UP) unlaunch(); 
  if (keyCode == DOWN) downPressed = false;
  if (keyCode == SHIFT) shiftPressed = false;
}


void launch(){
  int length = min(pinballs.length, numParticles);
  int count = 1;
  int index = -1;
  for(int i = 0; i < length-1; i++){
    for(int j = i+1; j < length; j++){
      if (colliding(pinballs[i], pinballs[j])){
        count++;
      }
    }
  }

  for(int i = 0; i < length; i++){
    if (colliding(pinballs[i], launcher)){
      index = i;
      for(int j = 0; j < length; j++){
        if (i!=j){
          if (colliding(pinballs[i], pinballs[j])){
            count++;
          }
        }
      }
    }
  }
  if (index!=-1){
    pinballs[index].vel.add(new Vec2(0, -1000*count));
  }
  launcher.pos.subtract(new Vec2(0, launcher.half_height));
}

void unlaunch(){
  launcher.pos.add(new Vec2(0, launcher.half_height));
}


boolean paused = true;
void draw(){
  if (!paused) update(0.8/frameRate);


  // if (!bkm.isPlaying() )
  // {
  //       bkm.rewind();
  //   bkm.trigger();
  // }

  // background(255); //White background
  background(img); 
  stroke(0,0,0);
  //fill(0,0,255);
  for (int i = 0; i < numParticles; i++){
    // fill(colList[i].r, colList[i].g, colList[i].b);
    fill(43, 78, 191);
    Circle circle = pinballs[i];
    circle(circle.center.x, circle.center.y, circle.radius*2);
    // circle(pos[i].x, pos[i].y, r*2); //(x, y, diameter)
  }
  
  fill(0, 220, 255);
  for (int i = 0; i<ballObstacle.length; i++){
    // ballObstacle[i].draw();

    beginShape();
    noStroke();
    texture(ball);
    vertex(ballObstacle[i].center.x-ballObstacle[i].radius, ballObstacle[i].center.y-ballObstacle[i].radius, 0, 0);
    vertex(ballObstacle[i].center.x+ballObstacle[i].radius, ballObstacle[i].center.y-ballObstacle[i].radius, ball.width, 0);
    vertex(ballObstacle[i].center.x+ballObstacle[i].radius, ballObstacle[i].center.y+ballObstacle[i].radius, ball.width, ball.height);
    vertex(ballObstacle[i].center.x-ballObstacle[i].radius, ballObstacle[i].center.y+ballObstacle[i].radius, 0, ball.height);
    stroke(4);
    endShape(CLOSE);
  }
  noStroke();
  fill(255, 255, 255, 0);
  bigBall.draw();
  stroke(4);
  // beginShape();
  // noStroke();
  // texture(bigball);
  // vertex(bigBall.center.x-bigBall.radius, bigBall.center.y-bigBall.radius, 0, 0);
  // vertex(bigBall.center.x+bigBall.radius, bigBall.center.y-bigBall.radius, bigball.width, 0);
  // vertex(bigBall.center.x+bigBall.radius, bigBall.center.y+bigBall.radius, bigball.width, bigball.height);
  // vertex(bigBall.center.x-bigBall.radius, bigBall.center.y+bigBall.radius, 0, bigball.height);
  // stroke(4);
  // endShape(CLOSE);

  // for (int i = 0; i<ballObstacle2.length; i++){
  //   ballObstacle2[i].draw();
  // }

  for (int i =0; i<lineObstacles.length; i++){
    lineObstacles[i].draw(255, 255, 255);
  }

  for (int i =0; i<lineObstacles2.length; i++){
    lineObstacles2[i].draw(255, 255, 255);
  }

  for (int i =0; i<flippers.length; i++){
    flippers[i].draw(255, 0, 0);
  }

  for (int i =0; i<triangleObstacles.length; i++){
    triangleObstacles[i].draw(255, 255, 255);
  }

  for (int i =0; i<triangleObstacles2.length; i++){
    triangleObstacles2[i].draw(255, 255, 255);
  }

  for (int i =0; i<exitBox.length; i++){
    fill(100, 100, 250, 127);
    noStroke();
    exitBox[i].draw();
    stroke(4);
    fill(0,0,0);
  }

  fill(255, 255, 255, 100);
  launcher.draw();

  fill(0, 125, 250);
  rect(50, 970, 170, 70);

  fill(0);
  textSize(40);
  text(str(score), 50, 970, 170, 70);
  for (int i = 0; i < numParticles; i++){
    pss[i].run();
  }
}
