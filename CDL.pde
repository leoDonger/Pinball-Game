import java.util.Iterator;

String line;

Circle [] detected_circles;

Circle [] allCircles;
Line [] allLines;
Box [] allBoxes;
int id = 0;
int count;
PrintWriter output;

// void setup(){
//   for (int i = 1; i < 11; i++){
//     String fileNumber = "task"+i;
//     process(fileNumber, false);
//     // process(fileNumber, true);
//   }
//   // process("task_sample", false);
// }

void process(String fileNumber, boolean toCheckAnswer){
  String fileName = "CollisionTasks\\CollisionTasks\\"+fileNumber+".txt";
  output = createWriter("CollisionTasks\\Solutions\\"+fileNumber+"_solution.txt");

  if(!toCheckAnswer){
    pre_process(fileName);
    hitInfo h = new hitInfo();

    int[] detected = new int[99999999];;
    count = 0;

    long start = System.nanoTime();

    for(int i = 0; i < allLines.length; i++){
      if (i != allLines.length-1){
        for(int ii = i+1; ii<allLines.length; ii++){
          if(colliding(allLines[i], allLines[ii])){
            detected[count++] = allLines[i].id;
            detected[count++] = allLines[ii].id;
            // println("id:", allLines[i].id, allLines[ii].id);
            // println("-----------");
          }
        }
      }
      for(int j = 0; j<allCircles.length; j++){
        if(colliding(allLines[i], allCircles[j])){
            detected[count++] = allLines[i].id;
            detected[count++] = allCircles[j].id;
            // println("id:", allLines[i].id, allCircles[j].id);
            // println("-----------");
        }
      }

      for(int k=0;k<allBoxes.length;k++){
        if(colliding(allLines[i], allBoxes[k])){
          detected[count++] = allLines[i].id;
          detected[count++] = allBoxes[k].id;
          // println("id:", allLines[i].id, allBoxes[k].id);
          //   println("-----------");
        }
      }
    }
    for(int i = 0; i < allCircles.length; i++){
      if (i != allCircles.length-1){
        for(int ii = i+1; ii<allCircles.length; ii++){
          if(colliding(allCircles[i], allCircles[ii])){
            detected[count++] = allCircles[i].id;
            detected[count++] = allCircles[ii].id;
            // println("id:", allCircles[i].id, allCircles[ii].id);
            // println("-----------");
          }
        }
      }
    for(int j = 0; j<allBoxes.length; j++){
      if(colliding(allCircles[i], allBoxes[j])){
          detected[count++] = allCircles[i].id;
          detected[count++] = allBoxes[j].id;
            // println("id:", allCircles[i].id, allBoxes[j].id);
            // println("-----------");
        }
      }
    }
    for(int i = 0; i < allBoxes.length-1; i++){
      for(int ii = i+1; ii<allBoxes.length; ii++){
        if(colliding(allBoxes[i], allBoxes[ii])){
          detected[count++] = allBoxes[i].id;
          detected[count++] = allBoxes[ii].id;
          // println("id:", allBoxes[i].id, allBoxes[ii].id);
          //   println("-----------");
        }
      }
    }
    long end = System.nanoTime();

    h.duration = (end-start)/ 1000000.0;
    h.detected = detected;

    output.println(h.report());
    output.close();
  }else{

    IntList a = new IntList();    // line-line
    IntList b = new IntList();    // line-circle
    IntList c = new IntList();    // line-box
    IntList d = new IntList();    // circle-circle
    IntList e = new IntList();    // circle-box
    IntList f = new IntList();    // box-box

    IntList cc = new IntList();;

    PrintWriter output2 = createWriter("CollisionTasks\\Checks\\"+fileNumber+"_check.txt");

    pre_process(fileName);
    hitInfo h = new hitInfo();

    int[] detected = new int[99999999];;
    int count = 0;

    long start = System.nanoTime();

    for(int i = 0; i < allLines.length; i++){
      if (i != allLines.length-1){
        for(int ii = i+1; ii<allLines.length; ii++){
          if(colliding(allLines[i], allLines[ii])){
            detected[count++] = allLines[i].id;
            detected[count++] = allLines[ii].id;
            a.append(allLines[i].id);
            a.append(allLines[ii].id);
          }
        }
      }

      for(int j = 0; j<allCircles.length; j++){
        if(colliding(allLines[i], allCircles[j])){
            detected[count++] = allLines[i].id;
            detected[count++] = allCircles[j].id;
            b.append(allLines[i].id);
            b.append(allCircles[j].id);
            cc.append(allCircles[j].id);
        }
      }

      for(int k=0;k<allBoxes.length;k++){
        if(colliding(allLines[i], allBoxes[k])){
          detected[count++] = allLines[i].id;
          detected[count++] = allBoxes[k].id;
          c.append(allLines[i].id);
          c.append(allBoxes[k].id);
        }
      }
    }

    for(int i = 0; i < allCircles.length; i++){
      if (i != allCircles.length-1){
        for(int ii = i+1; ii<allCircles.length; ii++){
          if(colliding(allCircles[i], allCircles[ii])){
            detected[count++] = allCircles[i].id;
            detected[count++] = allCircles[ii].id;
            d.append(allCircles[i].id);
            d.append(allCircles[ii].id);
            cc.append(allCircles[i].id);
            cc.append(allCircles[ii].id);
          }
        }
      }

      for(int j = 0; j<allBoxes.length; j++){
      if(colliding(allCircles[i], allBoxes[j])){
          detected[count++] = allCircles[i].id;
          detected[count++] = allBoxes[j].id;
          e.append(allCircles[i].id);
          e.append(allBoxes[j].id);
          cc.append(allCircles[i].id);
        }
      }
    }
    for(int i = 0; i < allBoxes.length-1; i++){
      for(int ii = i+1; ii<allBoxes.length; ii++){
        if(colliding(allBoxes[i], allBoxes[ii])){
          detected[count++] = allBoxes[i].id;
          detected[count++] = allBoxes[ii].id;
          f.append(allBoxes[i].id);
          f.append(allBoxes[ii].id);
        }
      }
    }
    long end = System.nanoTime();

    h.duration = (end-start)/ 1000000.0;
    h.detected = detected;

    output.println(h.report());
    output.close();

    output2.println(fileNumber+".txt");
    output2.println("Circles Colliding: " + (getUnique(cc.array(), cc.array().length)).length);
    output2.println("Line-line: " + (getUnique(a.array(), a.array().length)).length);
    output2.println("Line-circle: " + (getUnique(b.array(), b.array().length)).length);
    output2.println("Line-box: " + (getUnique(c.array(), c.array().length)).length);
    output2.println("Circles-Circle: " + (getUnique(d.array(), d.array().length)).length);
    output2.println("Circles-box: " + (getUnique(e.array(), e.array().length)).length);
    output2.println("Box-box: " + (getUnique(f.array(), f.array().length)).length);
    output2.close();
  }
}

void pre_process(String fileName){
  String [] lines;
  lines = loadStrings(fileName);

  int i = 0;

  while (i < lines.length){
    line = lines[i];
    String[] pieces = split(line, ": ");
    String shape = pieces[0];
    int count = int(pieces[1]);
    id += count;
    i+=2;

    if (shape.equals("Circles")){
      allCircles = new Circle[count];

      for (int j = 0; j < count; j = j+1) {
        line = lines[i];
        String[] data = split(line, " : ");
        String[] parameters = split(data[1], " ");
        int local_id = int(data[0]);

        Circle circleShape = new Circle(new Vec2(float(parameters[0]), float(parameters[1])), float(parameters[2]));
        circleShape.id = local_id;
        allCircles[j] = circleShape;
        i++;
      }
    }else if (shape.equals("Lines")){
      allLines = new Line[count];

      for (int j = 0; j < count; j = j+1) {
        line = lines[i];
        String[] data = split(line, " : ");
        String[] parameters = split(data[1], " ");
        int local_id = int(data[0]);

        Line lineShape = new Line(new Vec2(float(parameters[0]), float(parameters[1])), new Vec2(float(parameters[2]), float(parameters[3])));
        lineShape.id = local_id;
        allLines[j] = lineShape;
        i++;
      }
    }else if (shape.equals("Boxes")){
      allBoxes = new Box[count];

      for (int j = 0; j < count; j = j+1) {
        line = lines[i];
        String[] data = split(line, " : ");
        String[] parameters = split(data[1], " ");
        int local_id = int(data[0]);

        Box boxShape = new Box(new Vec2(float(parameters[0]), float(parameters[1])), float(parameters[2]), float(parameters[3]));
        boxShape.id = local_id;
        allBoxes[j] = boxShape;
        i++;
      }
    }else{
      println("Non-recoganizable shape");
      break;
    }
  }
}


int[] getUnique(int[] arr, int length) {
  IntList uniqueList = new IntList();

  for (int i = 0; i < length; i++) {
    if (!uniqueList.hasValue(arr[i]) && arr[i] != -1) {
      uniqueList.append(arr[i]);
    }
  }

  return uniqueList.array();
}

public class hitInfo{
  public int[] detected = new int[0];
  public float duration = 0.0;

  public void dataCleanUp(){
    detected = getUnique(detected, count);
    detected = sort(detected, detected.length);;
  }

  public String report(){
    dataCleanUp();

    String ret = "";
    ret += "Duration: " + duration + " ms\r\n";
    ret += "Num Collisions: " + detected.length + "\r\n";

    for(int i = 0; i < detected.length; i ++){
      ret += detected[i] + "\r\n";
    }
    return ret;
  }
}




//---------------
//Collsion detection fucntion Library
//---------------

public boolean colliding(Line l1, Line l2){
  boolean a = (sameSide(l1, l2.pt1, l2.pt2));
  boolean b = (sameSide(l2, l1.pt1, l1.pt2));
  if (!a && !b){
    return true;
  }else if (dot(l1.vec(), l2.vec()) == l1.length() * l2.length()){  // on the same line
    if ((onTheLine(l1, l1.pt1, l2.pt1, l2.pt2)) || 
        (onTheLine(l1, l1.pt2, l2.pt1, l2.pt2)) ||
        (onTheLine(l2, l2.pt1, l1.pt1, l1.pt2)) ||
        (onTheLine(l2, l2.pt2, l1.pt1, l1.pt2))) {
      return true;
    }
  }
  return false;
}

public boolean onTheLine(Line l1, Vec2 l1_pt, Vec2 l2_pt1, Vec2 l2_pt2) {
  float vec1 = cross(l1.vec(), l2_pt1.minus(l1_pt));
  float vec2 = cross(l1.vec(), l2_pt2.minus(l1_pt));
  return vec1 * vec2 == 0; // one point is on the line 
}

// from exercise
public boolean colliding(Circle c1, Circle c2){ // check
    float dist = (c2.center.minus(c1.center)).length();
    return dist <= (c1.radius + c2.radius);
}

public boolean colliding(Box b1, Box b2){ // check
    if ((abs(b1.pos.x - b2.pos.x) <= (b1.width + b2.width) /2) && (abs(b1.pos.y - b2.pos.y) <= (b1.height + b2.height) /2)) return true;
    return false;
}

// from exercise code
public boolean colliding(Line l, Circle c){ // check
  Vec2 toCircle1 = c.center.minus(l.pt1);
  Vec2 toCircle2 = c.center.minus(l.pt2);
  if (toCircle1.length() <= c.radius || toCircle2.length() <= c.radius) return true;

  float a = 1;  //Lenght of l_dir (we noramlized it)
  float b = -2*dot((l.vec()).normalized(),toCircle1); //-2*dot(l_dir,toCircle)
  float c_val = toCircle1.lengthSqr() - (c.radius)*(c.radius); //different of squared distances
  
  float d = b*b - 4*a*c_val; //discriminant 
  
  if (d >=0){ 
    //If d is positive we know the line is colliding, but we need to check if the collision line within the line segment
    //  ... this means t will be between 0 and the lenth of the line segment
    float t1 = (-b - sqrt(d))/(2*a); //Optimization: we only take the first collision [is this safe?]
    if (t1 > 0 && t1 < l.length()){
      return true;
    } 
  }
  return false;
}

public boolean colliding(Circle c, Line l){
  return colliding(l, c);
}

public boolean colliding(Line l, Box b){  // check
  if (abs(l.pt1.x - b.pos.x) <= b.half_width && abs(l.pt1.y - b.pos.y) <= b.half_height) return true;
  if (abs(l.pt2.x - b.pos.x) <= b.half_width && abs(l.pt2.y - b.pos.y) <= b.half_height) return true;

  if (colliding(l, b.top()) || colliding(l, b.bottom()) ||colliding(l, b.left()) ||colliding(l, b.right())) return true;
  return false;
}

public boolean colliding(Box b, Line l){
  return colliding(l, b);
}

public boolean colliding(Circle c, Box b){  // check
  Vec2 closest_point = new Vec2(clamp(c.center.x, b.pos.x - b.width/2, b.pos.x + b.width/2),
                              clamp(c.center.y, b.pos.y - b.height/2, b.pos.y + b.height/2));
  return (closest_point.minus(c.center)).length() <= c.radius;
}

public boolean colliding(Box b, Circle c){
  return colliding(c, b);
}

// from exercise
public boolean sameSide(Line l, Vec2 p1, Vec2 p2){
  float cp1 = cross(l.vec(), p1.minus(l.pt1));
  float cp2 = cross(l.vec(), p2.minus(l.pt1));
  return cp1 * cp2 >= 0;
}

//---------------
//Color class Library
//---------------

public class Col {
  public float r, g, b;
  
  public Col(float r, float g, float b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
}



//---------------
//Shape class Library
//---------------

abstract  class Shape{
  public int id = 0;
  abstract void display();
  public String toString(){
    return "here";
  }
}
public class Line extends Shape{
  public int id;
  public Vec2 pt1, pt2;
  public Vec2 center;
  
  public Line(Vec2 pt1, Vec2 pt2){
    this.pt1 = pt1;
    this.pt2 = pt2;
    center = new Vec2(abs(pt2.x-pt1.x), abs(pt2.y-pt1.y));
  }

  public Vec2 normalVector(){
    return new Vec2(-(pt2.y-pt1.y), pt2.x-pt1.x).normalized();
  }

  public Vec2 vec(){
    return pt2.minus(pt1);
  }

  public float length(){
    return pt1.minus(pt2).length();
  }

  public void display(){
    line(pt1.x, pt1.y, pt2.x, pt2.y);
  }

  public String toString(){
    return pt1.toString();
  }

  public void draw(){
    line(pt1.x, pt1.y, pt2.x, pt2.y);
  }

  public void draw(float weight){
    strokeWeight(weight); //Draw thicker lines
    line(pt1.x, pt1.y, pt2.x, pt2.y);
    strokeWeight(0); //Draw thicker lines
  }

  public void draw(float a, float b, float c){
    stroke(a, b, c);
    line(pt1.x, pt1.y, pt2.x, pt2.y);
    stroke(0, 0, 0);
  }
  
  public void draw(float a, float b, float c, float weight){
    strokeWeight(weight); //Draw thicker lines
    stroke(a, b, c);
    line(pt1.x, pt1.y, pt2.x, pt2.y);
    stroke(0, 0, 0);
    strokeWeight(0); //Draw thicker lines
  }
}

public class Circle extends Shape{
  public int id;
  public Vec2 center;
  public float radius;
  public Vec2 vel;
  public float mass;
  
  public Circle(Vec2 center, float radius){
    this.center = center;
    this.radius = radius;
  }

  public Circle(Vec2 center, float radius, Vec2 v){
    this.center = center;
    this.radius = radius;
    vel = v;
  }


  public void display(){
    circle(center.x, center.y, radius*2);
  }

  public String toString(){
    return center.toString();
  }

  public void draw(){
    circle(center.x, center.y, radius*2);
  }
}

public class Box extends Shape{
  public int id;
  public Vec2 pos;
  public float width, height;
  public float half_width, half_height;
  public Vec2 vel;

  public Box(Vec2 pos, float w, float h){
      this.pos = pos;
      this.width = w;
      this.height = h;
      half_width = w/2;
      half_height = h/2;
      vel = new Vec2(0, 0);
  }

  public Line top(){
    return new Line(new Vec2(pos.x - half_width, pos.y + half_height), 
              new Vec2(pos.x + half_width, pos.y + half_height));
  }
    
  public Line bottom(){
    return new Line(new Vec2(pos.x - half_width, pos.y - half_height), 
              new Vec2(pos.x + half_width, pos.y - half_height));
  }

  public Line left(){
    return new Line(new Vec2(pos.x - half_width, pos.y + half_height), 
              new Vec2(pos.x - half_width, pos.y - half_height));
  }

  public Line right(){
    return new Line(new Vec2(pos.x + half_width, pos.y + half_height), 
              new Vec2(pos.x + half_width, pos.y - half_height));
  }

  public void display(){
    rect(pos.x, pos.y, width, height);
  }

  public String toString(){
    return pos.toString();
  }
  
  public void draw(){
    rect(pos.x-half_width, pos.y-half_height, width, height, 5);
  }
}


public class Particle{
  Vec2 pos;
  Vec2 vel;
  float lifespan;

  public Particle(Vec2 p){
    pos = p;
    vel = new Vec2(random(-20, 20), random(-50, 10));
    lifespan = 255.0;
  }

  public void update() {
    pos.add(vel);
    lifespan -= 2.0;
  }

  public void draw() {
    stroke(255, lifespan);
    fill(250, 100, 100, lifespan);
    circle(pos.x, pos.y, 2.5*2);
  }

  public boolean isDead(){
    return lifespan < 0;
  }
}


class ParticleSystem {
  ArrayList<Particle> particles;
  Vec2 origin;

  ParticleSystem(Vec2 pos) {
    origin = pos;
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    for(int i = 0; i< 30; i++){
      Vec2 random = new Vec2(origin.x + random(-20, 20), origin.y + random(-20, 20));
      particles.add(new Particle(random));
    }
  }

  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.update();
      p.draw();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
  
  void clear(){
    particles = new ArrayList<Particle>();
  }
}




//---------------
//Vec 2 Library
//---------------

//Vector Library
//CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>

public class Vec2 {
  public float x, y;
  
  public Vec2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public String toString(){
    return "(" + x+ "," + y +")";
  }
  
  public float length(){
    return sqrt(x*x+y*y);
  }
  
  public float lengthSqr(){
    return x*x+y*y;
  }
  
  public Vec2 plus(Vec2 rhs){
    return new Vec2(x+rhs.x, y+rhs.y);
  }
  
  public void add(Vec2 rhs){
    x += rhs.x;
    y += rhs.y;
  }
  
  public Vec2 minus(Vec2 rhs){
    return new Vec2(x-rhs.x, y-rhs.y);
  }
  
  public void subtract(Vec2 rhs){
    x -= rhs.x;
    y -= rhs.y;
  }
  
  public Vec2 times(float rhs){
    return new Vec2(x*rhs, y*rhs);
  }
  
  public void mul(float rhs){
    x *= rhs;
    y *= rhs;
  }
  
  public void clampToLength(float maxL){
    float magnitude = sqrt(x*x + y*y);
    if (magnitude > maxL){
      x *= maxL/magnitude;
      y *= maxL/magnitude;
    }
  }
  
  public void setToLength(float newL){
    float magnitude = sqrt(x*x + y*y);
    x *= newL/magnitude;
    y *= newL/magnitude;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y);
    x /= magnitude;
    y /= magnitude;
  }
  
  public Vec2 normalized(){
    float magnitude = sqrt(x*x + y*y);
    return new Vec2(x/magnitude, y/magnitude);
  }
  
  public float distanceTo(Vec2 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    return sqrt(dx*dx + dy*dy);
  }
}

public float clamp(float val, float minL, float maxL){
  if (val < minL){
    return minL;
  }else if (val > maxL){
    return maxL;
  }else{
    return val;
  }
}

Vec2 interpolate(Vec2 a, Vec2 b, float t){
  return a.plus((b.minus(a)).times(t));
}

float interpolate(float a, float b, float t){
  return a + ((b-a)*t);
}

float dot(Vec2 a, Vec2 b){
  return a.x*b.x + a.y*b.y;
}

float cross(Vec2 a, Vec2 b){
  return a.x * b.y - a.y * b.x;
}

Vec2 projAB(Vec2 a, Vec2 b){
  return b.times(a.x*b.x + a.y*b.y);
}
