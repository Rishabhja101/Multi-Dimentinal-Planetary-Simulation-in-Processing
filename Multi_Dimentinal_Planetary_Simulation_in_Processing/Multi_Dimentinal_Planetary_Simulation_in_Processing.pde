Planet[] planets;

void setup() {
  size(2000, 2000, P2D);

  planets = new Planet[4];
  planets[0] = new Planet(3);
  planets[1] = new Planet(3);
  planets[2] = new Planet(3);
  planets[3] = new Planet(3);

  planets[0].setLocation(new float[]{ 500, 500, 0 });
  planets[1].setLocation(new float[]{ -100, 100, 0 });
  planets[2].setLocation(new float[]{ -200, -200, 0 });
  planets[3].setLocation(new float[]{ 200, 200, 0 });

  planets[0].velocity = new float[]{ 0, 0, 0 };
  planets[1].velocity = new float[]{ -1, 1, 0 };
  planets[2].velocity = new float[]{ 1, -1, 0 };
  planets[3].velocity = new float[]{ -1, -1, 0 };

  // planets[0].force = new float[]{ 0, 5, 0 };
}

void draw() {
  translate(width / 2, height / 2);
   background(0); 
  stroke(255);

  for (int i = 0; i < planets.length; i++) {
    planets[i].illistrate();
    planets[i].calculateForces(planets);
    planets[i].update();
  }
}


class Planet {
  float mass;
  float radius;
  float[] location;
  float[] velocity;
  float[] force;

  float G = 1;
  float fps = 600;


  Planet(int dimentions) {
    this.location = new float[dimentions];
    this.velocity = new float[dimentions];
    this.force = new float[dimentions];
    this.mass = 1;
    this.radius = 30;
  }

  void setLocation(float[] local) {
    for (int i = 0; i < local.length; i++) {
      this.location[i] = local[i];
    }
  }

  float distance(float[] otherDistances) {
    float dis = 0;
    for (int i = 0; i < this.location.length; i++) {
      dis += pow(this.location[i] - otherDistances[i], 2);
    }
    return pow(dis, 0.5);
  }

  void calculateForces(Planet[] planets) {
    //float[] newForce = new float[this.force.length];
    for (int n = 0; n < this.force.length; n++) {
      this.force[n] = 0;
      for (int i = 0; i < planets.length; i++) {
        this.force[n] += (planets[i].location[n] - this.location[n]);
        //if (planets[i].distance(this.location) != 0) {
        //  this.force[n] += (G * planets[i].mass * this.mass) / pow(this.location[n] - planets[i].location[n], 2);
        //}
      }
    }
    //  this.force = newForce;
  }

  void update() {
    for (int i = 0; i < this.force.length; i++) {
      this.velocity[i] += this.force[i] / fps;
      this.location[i] += this.velocity[i];
    }
  }

  void illistrate() {
    stroke(255);
    fill(255);
    ellipse(location[0], -location[1], radius*2, radius*2);
  }
}
