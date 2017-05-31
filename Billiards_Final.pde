import javax.swing.JOptionPane;
import ddf.minim.*;

String playerName1;
String playerName2;
Hole holes[] = new Hole[4];
boolean turnP1 = true;
Ball cueBall = new Ball();
Stick stick = new Stick();
Ball[] balls = new Ball[10];
poolTable table;
float power = 0;
float max = 80;
boolean hitting = false;
boolean gameOver = false;
Player p1 = new Player();
Player p2 = new Player();
int timer = 10000;


AudioSample file;
Minim minim;

void sound() //plays collision sound
{
  file.trigger();
}

boolean gameChecker()//checks if game is over
{
  int ballsIn = 0;
  if(cueBall.sunk == true)
    return true;
  for(int i = 0; i < balls.length; i++)
  {
    if(balls[i].sunk == true)
      ballsIn++;
  }
  if(ballsIn == balls.length)
    return true;
  else
    return false;
}


void setup()
{
  timer = 10000;
  playerName1 = JOptionPane.showInputDialog("Please enter Player 1's name");
  playerName2 = JOptionPane.showInputDialog("Please enter Player 2's name");
  PFont font = createFont("Ariel", 30);
  textFont(font);
  minim = new Minim(this);
  file = minim.loadSample("hitSound");
  size(700, 500);
  background(0);
  p1.points = 0;
  p2.points = 0;
  p1.turn = true;
  p2.turn = false;
  table = new poolTable();
  table.generate_board();
  cueBall.center.point.x = 200;
  cueBall.center.point.y = 270;
  cueBall.col = 255;
  cueBall.rad = 10;
  cueBall.sunk = false;
  
  holes[0] = new Hole(75, 125); //sets hole points
  holes[1] = new Hole(575, 125);
  holes[2] = new Hole(75, 425);
  holes[3] = new Hole(575, 425);
  
  for(int i = 0; i < holes.length; i++)
  {
      holes[i].rad = 25;
  }

  for(int i = 0; i < balls.length; i++)
  {
    balls[i] = new Ball();
    balls[i].rad = 10;
    balls[i].col = (int)random(0, 200);
    balls[i].sunk = false;

  }
  
  balls[0].center.point.x = width/2; //sets ball coordinates
  balls[1].center.point.x = width/2 + 2*balls[1].rad;
  balls[2].center.point.x = width/2 + 2*balls[2].rad;
  balls[3].center.point.x = width/2 + 4*balls[3].rad;
  balls[4].center.point.x = width/2 + 4*balls[4].rad;
  balls[5].center.point.x = width/2 + 4*balls[5].rad;
  balls[6].center.point.x = width/2 + 6*balls[6].rad;
  balls[7].center.point.x = width/2 + 6*balls[7].rad;
  balls[8].center.point.x = width/2 + 6*balls[8].rad;
  balls[9].center.point.x = width/2 + 6*balls[9].rad;
 
  
  balls[0].center.point.y = height/2;
  balls[1].center.point.y = height/2-balls[1].rad;
  balls[2].center.point.y = height/2+balls[2].rad;
  balls[3].center.point.y = height/2-2*balls[3].rad;
  balls[4].center.point.y = height/2;
  balls[5].center.point.y = height/2+2*balls[5].rad;
  balls[6].center.point.y = height/2-3*balls[6].rad;
  balls[7].center.point.y = height/2-balls[7].rad;
  balls[8].center.point.y = height/2+balls[8].rad;
  balls[9].center.point.y = height/2+3*balls[9].rad;
  cueBall.velocityX = 0;
  cueBall.velocityY = 0;
  
}
void draw()
{
  if(gameOver == false)//if gameOver is false
  {

    noStroke();
    background(0);
    text(timer/100, 40, 80); //displays timer

    table.generate_board(); //generates board
    for(int i = 0; i < holes.length; i++)//displays holes
      holes[i].displayHole();
    fill(255);
    colorMode(RGB);
 
    //Check player turn
    if(turnP1 == true)
    {
      text(playerName1 + ": " + p1.points, 40, 40);
    }
    else if(turnP1 == false)
    {
      text(playerName2 + ": " + p2.points, 40, 40);
    }
    stick.update(cueBall); //stick moves relative to cueBall
    for(int i = 0; i < balls.length; i++) //displays balls
       balls[i].display();
    cueBall.display();
    if(mousePressed) //power for hits
    {
      if(power <= max)
      {
        power += 0.5;
        stick.power(power);
        hitting = true;
      }
      else
      {
        stick.power(power);
        hitting = true;
      }
    }
    for(int i = 0; i < balls.length; i++) //checks for collisions
    {
        for(int j = i+1; j < balls.length; j++)
        {
            if(balls[i].contact(balls[j])) //returns if collision is true or false
              balls[i].collision(balls[j]); //collision
        }
           if(cueBall.contact(balls[i]))
              cueBall.collision(balls[i]); //cueBall collision
    }
    for(int i = 0; i < holes.length; i++) //checks if sunk
    {
      for(int j = 0; j < balls.length; j++)
      {
        if(holes[i].check_hole(balls[j]))
        {
          balls[j].sunk = true;
          balls[j].points(1); //adds points to correct player
        }
      }
      if(holes[i].check_hole(cueBall)) // checks if cueBall is sunk
      {
        cueBall.sunk = true;
        cueBall.points(-100);
      }
        
    }
    if(mousePressed == false && hitting == true) //runs if player had clicked for a cueBall hit
    {
      cueBall.hit(power); //hits with power based on how long mousePressed
      
      stick.placementX = 150;//resets the power variables
      power = 0;
      if(p1.turn == true) //changes player turn
      {
        p1.turn = false;
        p2.turn = true;
        turnP1 = false;
        timer = 10000;//resets timer
      }
      else
      {
        p1.turn = true;
        p2.turn = false;
        turnP1 = true;
        timer = 10000;
      }
      hitting = false;
    }
      println(p1.points + "  " + p2.points);
      gameOver = gameChecker();
      timer--;
    if(timer < 0 || cueBall.sunk)
    {
      if(p1.turn == true)
        p2.points += 100;
      if(p2.turn == true)
        p1.points += 100;
      gameOver = true;
    }
}
  if(gameOver == true)
  {
    fill(255);
    text("Play Again? y/n", width/2-100, height/2-10);
    if(p1.points > p2.points)
      text("Player 1 Wins", width/2-100, 200);
    if(p1.points < p2.points)
      text("Player 2 Wins", width/2-100, 200);
    if(p1.points == p2.points)
      text("It's a tie", width/2-100, 200);
    if(key == 'y' && keyPressed)
    {
      gameOver = false;
      setup();
    }
    if(key == 'n' && keyPressed)
      exit();
  }
}