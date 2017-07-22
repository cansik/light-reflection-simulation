int rayCount = 11;

float lightSpeed = 3;

ArrayList<LightRay> rays = new ArrayList<LightRay>();
ArrayList<LightRay> deadRays = new ArrayList<LightRay>();

ArrayList<Mirror> mirrors = new ArrayList<Mirror>();

PVector lightSource;

void setup()
{
  size(800, 600, FX2D);

  // create light source
  lightSource = new PVector(width / 2f, height / 8 * 7f);

  // add light rays
  addRays(rayCount);

  // setup mirrors
  mirrors.add(new Mirror(width / 2, height / 2, 100, 0));
  mirrors.add(new Mirror(width / 4, height / 2, 100, 20));
  mirrors.add(new Mirror(width / 4 * 3, height / 2, 100, 90));
}

void draw()
{
  background(55);

  // update and render
  deadRays.clear();
  for (LightRay ray : rays)
  {
    ray.run();

    if (ray.location.x < 0 ||
      ray.location.x > width ||
      ray.location.y < 0 || 
      ray.location.y > height)
      deadRays.add(ray);
  }

  rays.removeAll(deadRays);
  if (frameCount % 30 == 0)
    addRays(rayCount);

  // render mirrors
  for (Mirror m : mirrors)
  {
    m.render();
  }

  noStroke();
  fill(241, 196, 15);
  ellipse(lightSource.x, lightSource.y, 50, 50);
}

void addRays(int count)
{
  for (int i = 0; i < count; i++)
  {
    float x = lightSource.x;
    float y = lightSource.y;
    float angle = radians(map(i, 0, count, -180, 0));
    rays.add(new LightRay(x, y, angle));
  }
}

void keyPressed()
{
  addRays(rayCount);
}