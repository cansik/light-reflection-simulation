// returns true if p3 is on line p1, p2
boolean isPointOnLine (PVector p1, PVector p2, PVector p3)
{
  PVector va = PVector.sub(p1, p2);
  PVector vb = PVector.sub(p3, p2);
  float area = va.x * vb.y - va.y * vb.x;
  if (abs(area) < 0.1)
    return true;
  return false;
}

float i_x = 0;
float i_y = 0;

boolean getLineIntersection(float p0_x, float p0_y, float p1_x, float p1_y, float p2_x, float p2_y, float p3_x, float p3_y)
{
  float s1_x, s1_y, s2_x, s2_y;
  s1_x = p1_x - p0_x;     
  s1_y = p1_y - p0_y;
  s2_x = p3_x - p2_x;     
  s2_y = p3_y - p2_y;

  float s, t;
  s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
  t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);

  if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
  {
    // Collision detected
    i_x = p0_x + (t * s1_x);
    i_y = p0_y + (t * s1_y);
    return true;
  }

  return false; // No collision
}