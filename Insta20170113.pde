import java.util.*;

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
ArrayList<Particle> particles;

float len;
int row_count;
int column_count; 
float strength;

int click_count;

void setup()
{
  size(640, 640);
  frameRate(30);
  background(255);
  colorMode(HSB);
  
  len = 5;
  row_count = 122;
  column_count = 40;
  strength = 1.5;
  
  click_count = 0;
  
  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.2)));
  physics.setWorldBounds(new Rect(0, 0, width, height));
  
  particles = new ArrayList<Particle>();

  for(int c = 0; c < column_count; c += 1)
  {
    for(int r = 0; r < row_count; r += 1)
    {
      Particle p = new Particle(new Vec2D(10 + r * len, 10 + c * len));
      physics.addParticle(p);
      particles.add(p);
    }
  }
  
  for(int c = 0; c < column_count; c += 1)
  {
    for(int r = 0; r < row_count; r += 1)
    {
      int index = r + (c * row_count);    
      Particle p = particles.get(index);
    
      if(r != 0)
      {
        Particle prev = particles.get(index - 1);
        VerletSpring2D spring = new VerletSpring2D(p, prev, len, strength);
        physics.addSpring(spring);
      }
      
      if(c != 0)
      {
        Particle up = particles.get(index - row_count);
        VerletSpring2D spring = new VerletSpring2D(p, up, len, strength);
        physics.addSpring(spring);
      }
    }
  }
  
  Particle left_head = particles.get(0);
  left_head.lock();
  Particle right_head = particles.get(int(row_count - 1));
  right_head.lock();

}

void draw()
{
  physics.update();
  background(255);
    
  for(Particle p : particles)
  {
    p.display();
  }
  
}

void mouseClicked()
{  
  click_count += 1;
  
  if(click_count % 2 == 0)
  {
    Particle right = particles.get(row_count - 1);
    right.x = mouseX;
    right.y = mouseY;
  }else
  {
    Particle left = particles.get(0);
    left.x = mouseX;
    left.y = mouseY;
  }
}