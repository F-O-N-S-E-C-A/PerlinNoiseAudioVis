import ddf.minim.*;
import ddf.minim.analysis.*;

ArrayList<Dust> particles = new ArrayList<Dust>();
int num = 1024;
float noiseScale = 0.01/2;
int bands = num;

Minim minim;
AudioPlayer player;
BeatDetect beat;
FFT fft;

int shade = 0;
int hue = 0;

void setup() {
  frameRate(30);
  fullScreen();
  minim = new Minim(this);
  player = minim.loadFile("ep1.mp3", 1024);
  
  colorMode(HSB, 360, 100, 100);
  
  //size(800, 600);
  for (int i = 0; i < num; i++) {
    
    //particles.add(new Dust(random(width), random(height), color(180, 100, 100)));
    float hue = map (i, 0, num, 0, 100);
    particles.add(new Dust(random(width), random(height), color(hue, 100, 100)));
  }
  
  stroke(255);
  stroke(255, 50);
  background(0);

  player.play();
  beat = new BeatDetect();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  noiseSeed(int(random(0, 99)));
}


int count = 0;
void draw() {

  if (count > 100){
    count = 0;
    noiseSeed(int(random(0, 99)));
  }
  count++;
 
  
  fft.forward(player.mix);
  beat.detect(player.mix);
  
  if (beat.isOnset()) {
    hue = 15;
  } else {
    hue = 0;
  }
  
  // background with alpha
  fill(0, 12);
  rect(-1, -1, width+1, height+1);
  
  
  for (int i = 0; i < num; i++) {
    
    noiseScale = map((player.right.level() + player.left.level())/2, 0, 1, 0.001, 0.05);
    
    Dust d = particles.get(i);
    
    //float n = noise(d.pX * noiseScale, d.pY * noiseScale,  frameCount * noiseScale * noiseScale);
    float n = noise(d.pX * noiseScale, d.pY * noiseScale,  frameCount * noiseScale * noiseScale);
    float a = TAU * n;
    d.pX += cos(a);
    d.pY += sin(a);
    d.c = color(hue(d.c) + hue, 100, 100);
    int new_size = int(map(fft.getBand(i), 0, 7, 3, 5));
    /*if (new_size < d.size){
      d.size -= 1;
    } else {
      d.size = new_size;
    }*/
    d.size = new_size;
    
    
    if (!onScreen(d.pX, d.pY)) {
      d.pX = random(width);
      d.pY = random(height);
      //d.pY = random(i);
      
    }
    d.show();
  }
  //saveFrame("./frames/frame-######.png");

  
}

boolean onScreen(float x, float y) {
  return x >= 0 && x <= width && y >= 0 && y <= height;
}

class Dust {
  float pX;
  float pY;
  color c;
  int size;
  float hex_color;
  
  Dust(float pX, float pY, color c){
      this.c = c;
      this.pX = pX;
      this.pY = pY;
      this.size = 3;
      this.hex_color = hue(c);
  }
  
  void show(){
    stroke(c);
    fill(c);
    ellipse(pX, pY, 3, 3);
    if (size > 3){
      hexagon(pX, pY, size, PI/6.0);
      hexagon(pX, pY, size, 0);
      
    }
    
  }
  
  void hexagon(float x, float y, float radius, float r) {
    pushMatrix();
    translate(x, y);
    beginShape();
    rotate(r);
    noFill();
    hex_color = hue(c) + size + 10;
    if (hex_color > 360){
      hex_color = 0;
    }
    stroke(color(hex_color, 100, 100));
  
    for (int i = 0; i < 6; i++) {
      pushMatrix();
      float angle = PI*i/3;
      vertex(cos(angle) * radius, sin(angle) * radius);
      popMatrix();
    }
    endShape(CLOSE);
    popMatrix();
  }
    
}
