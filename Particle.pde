class Particle extends VerletParticle2D
{
  boolean changeColor;
  
  Particle(Vec2D loc)
  {
    super(loc);
  }
  
  void display()
  {
    fill((x + y) % 255, 255, 255);
    
    noStroke();
    rect(x, y, 10, 10);
  }
}