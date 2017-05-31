class Ball
{
  float rad;
  Point center = new Point();
  Point contact_point = new Point();
  color col;
  float velocityX;
  float velocityY;
  float slope;
  boolean sunk = false;
  boolean pointsFor = false;
  
  boolean contact(Ball b)
  {
   if(sunk == false && b.sunk == false)
   {
   //checks if it hits another ball by comparing distance between centers and the sum of their radii
     if (b==null)
     {
       return false;
     }
     float distance = sqrt(pow(abs(b.center.point.x - center.point.x), 2) + pow(abs(b.center.point.y-center.point.y), 2));
     if (distance < b.rad + rad )
     {
        return true;
     }
   }
   return false;
  }
  void collision(Ball b)
  {
    if(sunk == false)
    {
      sound();
      float k = ((velocityX - b.velocityX)*(center.point.x-b.center.point.x) + (velocityY - b.velocityY)*(center.point.y - b.center.point.y))/(pow(center.point.x - b.center.point.x, 2) + pow(center.point.y - b.center.point.y, 2));
      float changeX = center.point.x - b.center.point.x;
      float changeY = center.point.y - b.center.point.y;
      float velocityFinalXA = velocityX - k*changeX;
      float velocityFinalYA = velocityY - k*changeY;
      float velocityFinalXB = b.velocityX + k*changeX;
      float velocityFinalYB = b.velocityY + k*changeY;
      
      velocityX = velocityFinalXA;
      velocityY = velocityFinalYA;
      b.velocityX = velocityFinalXB;
      b.velocityY = velocityFinalYB;
      
      if(center.point.x < b.center.point.x)
      {
        center.point.x -= 1;
        b.center.point.x += 1;
      }
      if(center.point.x > b.center.point.x)
      {
        center.point.x += 1;
        b.center.point.x -= 1;
      }
      if(center.point.y < b.center.point.y)
      {
        center.point.y -= 1;
        b.center.point.y += 1;
      }
      if(center.point.y > b.center.point.y)
      {
        center.point.y += 1;
        b.center.point.y -= 1;
      }    
    }
  }
  void hit(float p)
  {
    sound();
    float xDiff = center.point.x - mouseX;
    float yDiff = center.point.y - mouseY;
    float hyp = sqrt(pow(xDiff, 2) + pow(yDiff, 2));

    velocityX += p/2*xDiff/hyp;
    velocityY += p/2*yDiff/hyp;
  }
  void display()
  {
    noStroke();
    colorMode(RGB);
    //fill(col, 200, 200);
    fill(col);
    if(sunk == false)
    {
      if(center.point.x - rad <= 75)
      {
        velocityX *= -1;
        center.point.x = 75 + rad + 1;
      }
      if(center.point.x + rad > 575)
      {
        velocityX *= -1;
        center.point.x = 575 - rad - 1;
      }
      if(center.point.y - rad <= 125)
      {
        velocityY *= -1;
        center.point.y = 125 + rad + 1;
      }
      if(center.point.y + rad > 425)
      {
        velocityY *= -1;
        center.point.y = 425 - rad - 1;
      }
      center.point.x += velocityX;
      center.point.y += velocityY;
      
      ellipse(center.point.x, center.point.y, 2*rad, 2*rad);
      }
      velocityX *= 0.95;
      velocityY *= 0.95;
    }
    void points(int n)
    {
      if(sunk == true)
      {  
        if(pointsFor == false)
        {
        if(p1.turn == true && col != 255)
          p2.points+=n;
        if(p2.turn == true && col != 255)
          p1.points+=n;
        if(p1.turn == true && col == 255)
          p1.points -= n;
        if(p2.turn == true && col == 255)
          p2.points -= n;
          
        pointsFor = true;
        }
      }
    }
}