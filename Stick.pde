class Stick
{
  int placementX = 150;
  int cueLength = 100;
  
  void update(Ball cueball)
  {
    stroke(#2896DE);
    strokeWeight(8);
    
    float distanceX = mouseX - cueball.center.point.x;
    float distanceY = mouseY - cueball.center.point.y;
    
    float cueLine = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
    float dx = mouseX + 2*distanceX*cueLength/cueLine;
    float dy = mouseY + 2*distanceY*cueLength/cueLine;
    
    line(mouseX, mouseY, dx , dy);
    
    
  }
  void power(float n)
  {
    colorMode(HSB);
    strokeWeight(1);
    for(int i = 0; i < n*4; i++)
    {
      stroke(i, 200, 200);
      line(placementX, 10, placementX, i/4+10);
      placementX++;
    }
    placementX = 150;
  }
}