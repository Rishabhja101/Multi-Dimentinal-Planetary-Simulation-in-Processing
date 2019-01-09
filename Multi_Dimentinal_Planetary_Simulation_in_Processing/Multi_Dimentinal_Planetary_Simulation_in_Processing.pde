Planet[] planets;

void setup() {
  size(2000, 2000, P2D);

  planets = new Planet[4];
  planets[0] = new Planet(3);
  planets[1] = new Planet(3);
  planets[2] = new Planet(3);
  planets[3] = new Planet(3);

  planets[0].setLocation(new float[]{ 0, 0, 0 });
  planets[1].setLocation(new float[]{ 0, 500, 0 });
  planets[2].setLocation(new float[]{ 300, 0, 0 });
  planets[3].setLocation(new float[]{ 0, 0, -400 });

  planets[0].mass = 10000;
  planets[1].mass = 10;
  planets[2].mass = 10;
  planets[3].mass = 50;
  
  planets[0].radius = 100;
  planets[1].radius = 15;
  planets[2].radius = 15;
  planets[3].radius = 20;

  planets[0].velocity = new float[]{ 0, 0, 0 };
  planets[1].velocity = new float[]{ 62, 0, 0 };
  planets[2].velocity = new float[]{ 0, 70, 0 };
  planets[3].velocity = new float[]{ 65, 65, 0 };

  // planets[0].force = new float[]{ 0, 5, 0 };
}

void draw() {
  translate(width / 2, height / 2);
  //background(0); 
  stroke(255);

  for (int i = 0; i < planets.length; i++) {
    planets[i].calculateForces(planets);
    planets[i].update();
    planets[i].illistrate();
  }
}


class Planet {
  float mass;
  float radius;
  float[] location;
  float[] velocity;
  float[] force;

  float G = 10;
  float fps = 10;


  Planet(int dimentions) {
    this.location = new float[dimentions];
    this.velocity = new float[dimentions];
    this.force = new float[dimentions];
    this.mass = 10;
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
        if ((this.location[n] - planets[i].location[n]) != 0){
          //this.force[n] += -(this.location[n] - planets[i].location[n]) / abs(this.location[n] - planets[i].location[n]) * (G * planets[i].mass * this.mass) / pow((this.location[n] - planets[i].location[n]), 2);
          this.force[n] += -(this.location[n] - planets[i].location[n]) / abs(this.location[n] - planets[i].location[n]) * (G * planets[i].mass * this.mass) / pow((planets[i].distance(this.location)), 2);
        }
        //if (planets[i].distance(this.location) != 0){
        //  this.force[n] += (this.location[n] - planets[i].location[n]);
        //  //this.force[n] += (this.location[n] - planets[i].location[n]) * (G * planets[i].mass * this.mass) / pow(this.location[n] - planets[i].location[n], 2);
        //  //this.force[n] *= (this.location[n] - planets[i].location[n]);
        //}
        ////if (planets[i].distance(this.location) != 0) {
        //  this.force[n] += (G * planets[i].mass * this.mass) / pow(this.location[n] - planets[i].location[n], 2);
        //}
      }
    }
    //  this.force = newForce;
  }

  void update() {
    for (int i = 0; i < this.force.length; i++) {
      this.velocity[i] += this.force[i] / this.mass;
      this.location[i] += this.velocity[i] / fps;
    }
  }

  void illistrate() {
    stroke(255);
    fill(255);
    ellipse(location[0], -location[1], radius*2, radius*2);
  }
}
