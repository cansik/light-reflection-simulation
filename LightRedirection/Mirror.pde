class Mirror {
  PVector location;
  float size;
  float angle;

  PVector D;
  PVector A; 
  PVector B;

  public Mirror(float x, float y, float size, float angle)
  {
    this.location = new PVector(x, y);
    this.size = size;
    this.angle = radians(angle);

    D = getDirectionVector();
  }

  public PVector getDirectionVector()
  {
    float hs = size / 2f;
    float x1 = hs * cos(angle);
    float y1 = hs * sin(angle);

    float x2 = hs * cos(angle + PI);
    float y2 = hs * sin(angle + PI);

    PVector a = new PVector(x1, y1);
    PVector b = new PVector(x2, y2);

    // translate
    a.add(location);
    b.add(location);

    A = a;
    B = b;

    return PVector.sub(b, a);
  }

  public void render()
  {
    // reset translation & rotation
    noFill();
    strokeWeight(4);
    stroke(236, 240, 241);

    line(A.x, A.y, B.x, B.y);

    strokeWeight(1);
    stroke(236, 240, 241);

    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    float hs = size / 2f;
    line(-hs, 0, hs, 0);
    popMatrix();
  }
}