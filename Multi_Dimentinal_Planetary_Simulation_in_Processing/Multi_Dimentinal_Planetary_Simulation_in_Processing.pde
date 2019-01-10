Planet[] planets;

void setup() {
  size(2000, 2000, P2D);

  planets = new Planet[500];
  planets[0] = new Planet(3);
  planets[1] = new Planet(3);
  planets[2] = new Planet(3);
  planets[3] = new Planet(3);

  planets[0].setLocation(new float[]{ 0, 0, 0 });
  planets[1].setLocation(new float[]{ -9000, 0, 0 });
  planets[2].setLocation(new float[]{ 300, 0, 0 });
  planets[3].setLocation(new float[]{ 0, 500, 0 });

  planets[0].mass = 10000;
  planets[1].mass = 0;
  planets[2].mass = 0;
  planets[3].mass = 0;

  planets[0].radius = 5000;
  planets[1].radius = 150;
  planets[2].radius = 150;
  planets[3].radius = 150;

  planets[0].velocity = new float[]{ 0, 0, 0 };
  planets[1].velocity = new float[]{ 0, 23, 0 };
  planets[2].velocity = new float[]{ 0, 80, 0 };
  planets[3].velocity = new float[]{ 62, 0, 0 };
  
  planets[0].affected = false;
 // planets[1].affected = false;

  for (int i = 4; i < planets.length; i++) {
    planets[i] = new Planet(3);
    if (i % 5 == 10){
 //     planets[i].setLocation(new float[]{ pow(-1, i % 2) * (500 + i), 0, 0 });
    }
    else{
      planets[i].setLocation(new float[]{ pow(-1, i % 2) * (300 + i), 0,  pow(-1, i % 2) * (i % 3) * 35 });
     // planets[i].setLocation(new float[]{ pow(1, i % 2) * 800, 400, 0 });
    }
    planets[i].mass = 0.000;
    planets[i].radius = 150;
    //planets[i].velocity = new float[]{ -pow(1, i % 2) * pow((200 + i) * 1.7 * 100000 / pow(200 + i, 2), 0.5), 0, 0 };
    //planets[i].velocity = new float[]{ -pow(1, i % 2) * pow((300 + i) * 1 * 100000 / pow(300 + i, 2), 0.5), 0, 0 };
    planets[i].velocity = new float[]{ 0, pow(-1, i % 2) * pow((300 + i) * 1.7 * 100000 / pow(300 + i, 2), 0.5), pow(-1, i % 2) * i / 70};
  }

  // planets[0].force = new float[]{ 0, 5, 0 };
}

void draw() {
  translate(width / 2, height / 2);
  background(0); 
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
  float fps = 1;
  
  boolean affected = true;


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
        if ((this.location[n] - planets[i].location[n]) != 0) {
          //this.force[n] += -(this.location[n] - planets[i].location[n]) / abs(this.location[n] - planets[i].location[n]) * (G * planets[i].mass * this.mass) / pow((this.location[n] - planets[i].location[n]), 2);
          this.force[n] += -(this.location[n] - planets[i].location[n]) / abs(this.location[n] - planets[i].location[n]) * (G * planets[i].mass) / pow((planets[i].distance(this.location)), 2);
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
    if (affected){
      for (int i = 0; i < this.force.length; i++) {
        this.velocity[i] += this.force[i];
        this.location[i] += this.velocity[i] / fps;
      }
    }
  }

  void illistrate() {
    stroke(255);
    fill(255);
   // ellipse(location[0], -location[1], radius*2 / 310, radius*2 / 310);
    ellipse(location[0], -location[1], radius*2 / (310 - this.location[2]), radius*2 / (310 - this.location[2]));
  }
}
