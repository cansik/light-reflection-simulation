class LightRay
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float angle;

  LightRay(float x, float y, float angle) {
    acceleration = new PVector(0, 0);

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    this.angle = angle;
    velocity = new PVector(cos(angle), sin(angle));
    velocity.mult(lightSpeed);

    location = new PVector(x, y);
    r = 2.0;
    maxspeed = lightSpeed;
    maxforce = 0.5;
  }

  void run() {
    checkCollision();
    update();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void checkCollision() {
    PVector lastPos = PVector.sub(location, velocity);

    for (Mirror m : mirrors)
    {
      if (!getLineIntersection(m.A.x, m.A.y, m.B.x, m.B.y, location.x, location.y, lastPos.x, lastPos.y))
        continue;

      float angle = PVector.angleBetween(m.D, velocity);
      float rotationAngle = -2 * angle;

      velocity.rotate(rotationAngle);
      location.add(velocity);
    }
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);

    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up

    //draw ellipse with infos
    fill(255, 100);
    stroke(241, 196, 15);
    strokeWeight(1f);

    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}