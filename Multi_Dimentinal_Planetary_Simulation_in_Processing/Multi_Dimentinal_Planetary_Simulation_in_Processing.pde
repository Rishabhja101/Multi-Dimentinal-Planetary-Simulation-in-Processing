Planet[] planets;
float angle = 0;

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

    int dimentions = 3;
    float[][] rotationMatrixX = new float[dimentions][]; 
    for (int n = 0; n < rotationMatrixX.length; n++){
      rotationMatrixX[n] = new float[dimentions];
      for (int i = 0; i < rotationMatrixX.length; i++){
        if ((n == 0 && i == 0) ||(n == 1 && i == 1)){
          rotationMatrixX[n][i] = cos(angle);
        } 
        else if(n == 0 && i == 1){
          rotationMatrixX[n][i] = -sin(angle);
        }
        else if(n == 1 && i == 0){
          rotationMatrixX[n][i] = sin(angle);
        }
        else if (n == i){
          rotationMatrixX[n][i] = 1;
        }
        else {
          rotationMatrixX[n][i] = 0;
        }
      }
    }
    
    float[][] rotationMatrixY = new float[dimentions][]; 
    for (int n = 0; n < rotationMatrixY.length; n++){
      rotationMatrixY[n] = new float[dimentions];
      for (int i = 0; i < rotationMatrixY.length; i++){
        if ((n == 0 && i == 0) ||(n == rotationMatrixY.length - 2 && i == rotationMatrixY.length - 2)){
          rotationMatrixY[n][i] = cos(angle);
        } 
        else if(n == 0 && i == rotationMatrixY.length - 2){
          rotationMatrixY[n][i] = -sin(angle);
        }
        else if(n == rotationMatrixY.length - 2 && i == 0){
          rotationMatrixY[n][i] = sin(angle);
        }
        else if (n == i){
          rotationMatrixY[n][i] = 1;
        }
        else{
          rotationMatrixY[n][i] = 0;
        }
      }
    }
    
    float[][] rotationMatrixZ = new float[dimentions][]; 
    for (int n = 0; n < rotationMatrixZ.length; n++){
      rotationMatrixZ[n] = new float[dimentions];
      for (int i = 0; i < rotationMatrixZ.length; i++){
        if ((n == rotationMatrixZ.length - 1 && i == rotationMatrixZ.length - 1) ||(n == rotationMatrixZ.length - 2 && i == rotationMatrixZ.length - 2)){
          rotationMatrixZ[n][i] = cos(angle);
        } 
        else if(n == rotationMatrixZ.length - 2 && i == rotationMatrixZ.length - 1){
          rotationMatrixZ[n][i] = -sin(angle);
        }
        else if(n == rotationMatrixZ.length - 1 && i == rotationMatrixZ.length - 2){
          rotationMatrixZ[n][i] = sin(angle);
        }
        else if (n == i){
          rotationMatrixZ[n][i] = 1;
        }
        else{
          rotationMatrixZ[n][i] = 0;
        }
      }
    }


  for (int i = 0; i < planets.length; i++) {
    planets[i].calculateForces(planets);
    planets[i].update();
    planets[i].illistrate(rotationMatrixX, rotationMatrixY, rotationMatrixZ);
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
  
  float[][] projectionMatrix(float[][] point, float scale){
    float z = 1 / (scale - point[point.length - 1][0]); 
    float[][] projectionMatrix = new float[point.length - 1][];
    for (int n = 0; n < projectionMatrix.length; n++){
      projectionMatrix[n] = new float[point.length];
      for (int i = 0; i < point.length; i++){
        if (n == i){
          projectionMatrix[n][i] = z;
        }
        else{
          projectionMatrix[n][i] = 0;
        }
      }
    }
    return projectionMatrix;
  }
  
  float[][] multiplyMatrices(float[][] a, float[][] b){
    float[][] productMatrix = new float[a.length][];
    for(int i = 0; i < productMatrix.length; i++){
      productMatrix[i] = new float[b[0].length];
    }
    for (int x = 0; x < productMatrix.length; x++){
      for (int y = 0; y < productMatrix[0].length; y++){
        productMatrix[x][y] = 0;
        for (int i = 0; i < b.length; i++){
          productMatrix[x][y] += a[x][i] * b[i][y];
        }
      }    
    }
    return productMatrix;
  }
  
  float[][] formatPoint(float[][] raw){
    float[][] output = new float[raw[0].length][];
    for (int i = 0; i < output.length; i++){
      output[i] = new float[raw.length];
    }
    for (int x = 0; x < output.length; x++){
      for (int y = 0; y < output[0].length; y++){
        output[x][y] = raw[y][x];
      }    
    }
    return output;
  }

  void illistrate(float[][] rotationX, float[][] rotationY, float[][] rotationZ) {
    stroke(255);
    fill(255);
    
    float[][] point = new float[1][];
    point[0] = this.location;
    point = formatPoint(point);
    
  //  point = multiplyMatrices(rotationY, point);
  //  point = multiplyMatrices(rotationZ, point);
    
   // if (this.location.length == 4){
   //   float z = 1 / (2 - point[point.length - 1][0]);
   //   point = multiplyMatrices(new float[][]{ {z, 0, 0, 0}, {0, z, 0, 0}, {0, 0, z, 0} }, point);
   // }
    
    point = multiplyMatrices(projectionMatrix(point, 2), point);
    point = formatPoint(point);
    
    ellipse(point[0][0], -point[0][1], radius*2 / (310 - this.location[2]), radius*2 / (310 - this.location[2]));
    
   // ellipse(location[0], -location[1], radius*2 / 310, radius*2 / 310);
   // ellipse(location[0], -location[1], radius*2 / (310 - this.location[2]), radius*2 / (310 - this.location[2]));
  }
}
