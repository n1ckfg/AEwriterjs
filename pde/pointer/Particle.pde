class Particle {
  ArrayList AEpath = new ArrayList();
  PVector p;

  Particle() {
    p = new PVector(width/2, height/2);
  }

  void update() {
    if(!useLeap){
      p = new PVector(mouseX, mouseY);
    }else{
      try{
        float posX = map(pos[0],-250,250,0,640);
        float posY = map(pos[1],550,30,0,360);
        p = new PVector(posX,posY);
      }catch(Exception e){ }
    }
    if (record) AEpath.add(p);
  }

  void draw() {
    noStroke();
    fill(255, 0, 0);
    ellipse(p.x, p.y, 5, 5);    
    if(record){
      for (int i=0;i<AEpath.size();i++) {
        if(i>0){
          PVector p1 = (PVector) AEpath.get(i);
          PVector p2 = (PVector) AEpath.get(i-1);
          stroke(255, 0, 0);
          strokeWeight(1);
          noFill();
          line(p1.x, p1.y, p2.x, p2.y);
        }
      }
    }
  }

  void run() {
    update();
    draw();
  }
}