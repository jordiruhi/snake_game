PVector head, dir, food;
ArrayList<PVector> snake;
int scale = 20;

boolean showNumbers = false;

void setup()
{
  fullScreen();
  head = new PVector(0, 0);
  dir = new PVector(1, 0);
  food = new PVector();
  getRandomPosition(food);

  snake = new ArrayList<PVector>();
  snake.add(head);
  snake.add(new PVector());

  frameRate(15);
}

void draw()
{
  //  checks if the food has been eaten
  if (head.x == food.x && head.y == food.y)
  {
    getRandomPosition(food);
    snake.add(new PVector());
  }

  //  move the tail
  for (int i = snake.size()-1; i > 0; i--)
  {
    snake.get(i).x = snake.get(i-1).x;
    snake.get(i).y = snake.get(i-1).y;
  }

  //  move the snake's head
  head.x += dir.x;
  head.y += dir.y;

  //  checks if the head hits the tail
  if (checkTail())
    die();

  //  checks if the head goes out of the window boundaries
  if (head.x < 0 || head.x > width/scale || head.y < 0 || head.y > height/scale)
    die();

  render();
}

void render()
{
  background(50);

  for (int i = 1; i < snake.size(); i++)
  {
    fill(255);
    rect(snake.get(i).x * scale, snake.get(i).y * scale, scale, scale);
  }
  fill(255, 255, 0);
  rect(head.x * scale, head.y * scale, scale, scale);

  fill(255, 0, 0);
  rect(food.x * scale, food.y * scale, scale, scale);

  fill(255);
  textSize(20);
  textAlign(LEFT, LEFT);
  text("score: "+(snake.size()-1), 0, 20);
  if (showNumbers)
  {
    for (int i = 0; i < snake.size(); i++)
    {
      text(i+": ("+(int) snake.get(i).x+", "+(int) snake.get(i).y+")", 0, 40 + i*20);
    }
  }
}

boolean checkTail()
{
  boolean a = false;
  for (int i = snake.size()-1; i > 0; i--)
  {
    if (head.x == snake.get(i).x && head.y == snake.get(i).y)
    {
      a = true;
      break;
    }
  }
  return a;
}

void getRandomPosition(PVector vec)
{
  vec.x = (int) random(width) / scale;
  vec.y = (int) random(height) / scale;
}

void die()
{
  setup();
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == RIGHT)
    {
      dir.x = 1;
      dir.y = 0;
    }
    if (keyCode == LEFT)
    {
      dir.x = -1;
      dir.y = 0;
    }
    if (keyCode == DOWN)
    {
      dir.x = 0;
      dir.y = 1;
    }
    if (keyCode == UP)
    {
      dir.x = 0;
      dir.y = -1;
    }

    if (keyCode == CONTROL)
    {
      showNumbers = !showNumbers;
    }

    //  checks if the head hits the tail
    for (int i = snake.size()-1; i > 0; i--)
    {
      if (head.x == snake.get(i).x && head.y == snake.get(i).y)
        die();
    }
  }
}
